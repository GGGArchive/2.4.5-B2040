package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.mafia.vo.AchievementVO;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   
   public class MafiaAchievementData
   {
       
      
      public var achievements:Vector.<AchievementVO>;
      
      public function MafiaAchievementData()
      {
         super();
         this.achievements = new Vector.<AchievementVO>();
      }
      
      public function parseData(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:AchievementVO = null;
         param1.shift();
         param1.shift();
         this.achievements = new Vector.<AchievementVO>();
         var _loc2_:Array = String(param1).split("#");
         _loc2_.pop();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = String(_loc2_[_loc3_]).split("+");
            _loc5_ = new AchievementVO();
            _loc5_.achievementId = _loc3_ + 1;
            _loc5_.achievementLevel = _loc4_[0];
            _loc5_.achievementValue = _loc4_[1];
            _loc5_.achievementNextValue = _loc4_[2];
            this.achievements.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function generateItem(param1:AchievementVO) : MovieClip
      {
         var _loc2_:String = null;
         var _loc4_:MovieClip = null;
         _loc2_ = this.validateItem(param1.achievementLevel > 0?uint(param1.achievementId):uint(0));
         var _loc3_:Class = getDefinitionByName(_loc2_) as Class;
         _loc4_ = new _loc3_();
         _loc4_.properties = param1;
         _loc4_.mouseEnabled = false;
         _loc4_.mouseChildren = false;
         return _loc4_;
      }
      
      public function validateItem(param1:uint) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = "AC_Null";
               break;
            case 1:
               _loc2_ = "AC_Dungeons";
               break;
            case 2:
               _loc2_ = "AC_Duels";
               break;
            case 3:
               _loc2_ = "AC_Quests";
               break;
            case 4:
               _loc2_ = "AC_EarnCash";
               break;
            case 5:
               _loc2_ = "AC_Money";
               break;
            case 6:
               _loc2_ = "AC_Honour";
               break;
            case 7:
               _loc2_ = "AC_FamilyCash";
               break;
            case 8:
               _loc2_ = "AC_Friends";
               break;
            case 9:
               _loc2_ = "AC_Login";
               break;
            case 10:
               _loc2_ = "AC_Epic";
         }
         return _loc2_;
      }
   }
}
