package com.goodgamestudios.mafia.model.components.user.quest
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.QuestType;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBTask;
   import com.goodgamestudios.mafia.controller.protobuf.quest.updatequest.PBQuestUpdateQuestResponse;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.quest.QuestRewardVO;
   import com.goodgamestudios.mafia.vo.quest.QuestTaskVO;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class MafiaQuestData
   {
       
      
      public var activeQuests:Vector.<QuestVO>;
      
      private var _newQuestsAvailable:Boolean;
      
      private var _cityToUnlock:City;
      
      private var _cityToUnlockQuestId:int;
      
      public function MafiaQuestData()
      {
         super();
      }
      
      public static function parseQuest(param1:PBQuest) : QuestVO
      {
         var _loc3_:PBTask = null;
         var _loc4_:QuestTaskVO = null;
         var _loc5_:QuestRewardVO = null;
         var _loc2_:QuestVO = new QuestVO();
         _loc2_.id = param1.questId;
         _loc2_.type = ProtobufEnumTranslator.translateProtoQuestType(param1.questType);
         _loc2_.questStatus = ProtobufEnumTranslator.translateProtoQuestStatus(param1.questStatus);
         if(param1.hasDistrictNumber)
         {
            _loc2_.districtNumber = param1.districtNumber;
         }
         if(param1.hasCity)
         {
            _loc2_.city = ProtobufEnumTranslator.translateProtoCity(param1.city);
         }
         else
         {
            _loc2_.city = City.None;
         }
         _loc2_.tasks = new Vector.<QuestTaskVO>();
         for each(_loc3_ in param1.tasks)
         {
            _loc4_ = new QuestTaskVO();
            _loc4_.id = _loc3_.taskId;
            _loc4_.iconId = _loc3_.iconId;
            _loc4_.requiredValue = _loc3_.requiredValue;
            _loc4_.currentValue = _loc3_.currentValue;
            _loc4_.city = !!_loc3_.hasCity?ProtobufEnumTranslator.translateProtoCity(_loc3_.city):City.None;
            _loc4_.districtNumber = !!_loc3_.hasDistrictNumber?int(_loc3_.districtNumber):-1;
            _loc2_.tasks.push(_loc4_);
         }
         if(param1.hasReward)
         {
            _loc5_ = new QuestRewardVO();
            _loc5_.cash = !!param1.reward.hasCash?uint(param1.reward.cash):uint(0);
            _loc5_.gold = !!param1.reward.hasGold?uint(param1.reward.gold):uint(0);
            _loc5_.xp = !!param1.reward.hasXp?uint(param1.reward.xp):uint(0);
            _loc5_.ap = !!param1.reward.hasAp?uint(param1.reward.ap):uint(0);
            if(param1.reward.hasItem)
            {
               _loc5_.item = MafiaItemData.parseItem(param1.reward.item,ItemLocation.None,0);
            }
            _loc5_.unlockCity = !!param1.reward.hasUnlockCity?ProtobufEnumTranslator.translateProtoCity(param1.reward.unlockCity):City.None;
            _loc2_.reward = _loc5_;
         }
         return _loc2_;
      }
      
      public function get hasActiveQuests() : Boolean
      {
         return this.activeQuests && this.activeQuests.length > 0;
      }
      
      public function get numActiveQuests() : uint
      {
         return !!this.activeQuests?uint(this.activeQuests.length):uint(0);
      }
      
      public function get newQuestsAvailable() : Boolean
      {
         return this._newQuestsAvailable;
      }
      
      public function parseActiveQuests(param1:Array, param2:Boolean) : void
      {
         var _loc4_:PBQuest = null;
         var _loc5_:QuestVO = null;
         var _loc6_:QuestVO = null;
         var _loc7_:Boolean = false;
         var _loc8_:QuestVO = null;
         var _loc3_:Vector.<QuestVO> = this.activeQuests;
         this.activeQuests = new Vector.<QuestVO>();
         for each(_loc4_ in param1)
         {
            _loc5_ = parseQuest(_loc4_);
            this.activeQuests.push(_loc5_);
         }
         this._newQuestsAvailable = param2;
         if(param2 && _loc3_ != null)
         {
            for each(_loc6_ in this.activeQuests)
            {
               _loc7_ = true;
               for each(_loc8_ in _loc3_)
               {
                  if(_loc6_.id == _loc8_.id)
                  {
                     _loc7_ = false;
                     break;
                  }
               }
               if(_loc7_)
               {
                  BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.QUEST_STARTED,[_loc6_]));
               }
            }
         }
      }
      
      public function parseQuestUpdate(param1:PBQuestUpdateQuestResponse) : void
      {
         var _loc2_:QuestVO = null;
         var _loc3_:QuestTaskVO = null;
         var _loc4_:uint = 0;
         if(this.activeQuests)
         {
            for each(_loc2_ in this.activeQuests)
            {
               if(_loc2_.id == param1.questId)
               {
                  for each(_loc3_ in _loc2_.tasks)
                  {
                     if(_loc3_.id == param1.taskId)
                     {
                        _loc4_ = _loc3_.currentValue;
                        _loc3_.currentValue = param1.value;
                        if(!_loc2_.complete)
                        {
                           BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.TASK_PROGRESS,[_loc2_,_loc3_,_loc4_]));
                        }
                        break;
                     }
                  }
                  break;
               }
            }
         }
      }
      
      public function viewedNewQuests() : void
      {
         this._newQuestsAvailable = false;
      }
      
      public function getQuestById(param1:uint) : QuestVO
      {
         var _loc2_:QuestVO = null;
         for each(_loc2_ in this.activeQuests)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get activeCityQuest() : QuestVO
      {
         var _loc1_:QuestVO = null;
         for each(_loc1_ in this.activeQuests)
         {
            if(_loc1_.type == QuestType.CityQuest)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get cityToUnlock() : City
      {
         var _loc1_:QuestVO = null;
         for each(_loc1_ in this.activeQuests)
         {
            if(_loc1_.type == QuestType.CityUnlockQuest && _loc1_.tasks[0])
            {
               this._cityToUnlock = _loc1_.reward.unlockCity;
            }
         }
         return this._cityToUnlock;
      }
      
      public function get cityToUnlockQuestId() : int
      {
         var _loc1_:QuestVO = null;
         for each(_loc1_ in this.activeQuests)
         {
            if(_loc1_.type == QuestType.CityUnlockQuest)
            {
               this._cityToUnlockQuestId = _loc1_.id;
            }
         }
         return this._cityToUnlockQuestId;
      }
   }
}
