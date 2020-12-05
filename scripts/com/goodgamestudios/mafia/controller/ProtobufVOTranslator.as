package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyCrest;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyCrestPart;
   import com.goodgamestudios.mafia.controller.protobuf.quest.PBQuestReward;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestPartVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.goodgamestudios.mafia.vo.quest.QuestRewardVO;
   
   public class ProtobufVOTranslator
   {
       
      
      public function ProtobufVOTranslator()
      {
         super();
      }
      
      public static function translateProtoFamilyCrest(param1:PBFamilyCrest) : FamilyCrestVO
      {
         var _loc2_:FamilyCrestVO = new FamilyCrestVO();
         _loc2_.primary = translateProtoFamilyCrestPart(param1.primary);
         _loc2_.secondary = translateProtoFamilyCrestPart(param1.secondary);
         _loc2_.banderole = translateProtoFamilyCrestPart(param1.banderole);
         return _loc2_;
      }
      
      public static function translateProtoFamilyCrestPart(param1:PBFamilyCrestPart) : FamilyCrestPartVO
      {
         var _loc2_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc2_.category = param1.category;
         _loc2_.type = param1.type;
         _loc2_.variation = param1.variation;
         _loc2_.color = param1.color;
         _loc2_.costGold = param1.price;
         return _loc2_;
      }
      
      public static function translateFamilyCrestToProto(param1:FamilyCrestVO) : PBFamilyCrest
      {
         var _loc2_:PBFamilyCrest = new PBFamilyCrest();
         _loc2_.primary = translateFamilyCrestPartToProto(param1.primary);
         _loc2_.secondary = translateFamilyCrestPartToProto(param1.secondary);
         _loc2_.banderole = translateFamilyCrestPartToProto(param1.banderole);
         return _loc2_;
      }
      
      public static function translateFamilyCrestPartToProto(param1:FamilyCrestPartVO) : PBFamilyCrestPart
      {
         var _loc2_:PBFamilyCrestPart = new PBFamilyCrestPart();
         _loc2_.category = param1.category;
         _loc2_.type = param1.type;
         _loc2_.variation = param1.variation;
         _loc2_.color = param1.color;
         _loc2_.price = param1.costGold;
         return _loc2_;
      }
      
      public static function translatePBQuestRewardToQuestRewardVO(param1:PBQuestReward) : QuestRewardVO
      {
         var _loc2_:QuestRewardVO = new QuestRewardVO();
         if(param1)
         {
            _loc2_.cash = param1.cash;
            _loc2_.gold = param1.gold;
            _loc2_.ap = param1.ap;
            _loc2_.xp = param1.xp;
            _loc2_.unlockCity = ProtobufEnumTranslator.translateProtoCity(param1.unlockCity);
            if(param1.hasItem)
            {
               _loc2_.item = MafiaItemData.parseItem(param1.item,ItemLocation.Inventory,0);
            }
         }
         return _loc2_;
      }
   }
}
