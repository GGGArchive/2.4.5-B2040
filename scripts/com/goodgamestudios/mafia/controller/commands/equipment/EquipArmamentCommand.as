package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.PBEquipmentEquipArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.PBEquipmentEquipArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.equiparmament.response.PBEquipmentEquipArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class EquipArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function EquipArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int = 1, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:PBEquipmentEquipArmamentRequest = new PBEquipmentEquipArmamentRequest();
         _loc5_.source = param1;
         _loc5_.amount = param2;
         _loc5_.targetX = param3;
         _loc5_.targetY = param4;
         _loc5_.armamentNumber = MafiaModel.userData.armamentPresetData.activeArmament;
         ProtobufController.getInstance().sendRequest(_loc5_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:uint = 0;
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentEquipArmamentResponse = param1 as PBEquipmentEquipArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentEquipArmamentResult.OK:
               if(MafiaTutorialController.getInstance().isActive)
               {
                  switch(MafiaTutorialController.getInstance().tutorialState)
                  {
                     case MafiaTutorialController.TUT_STATE_SELECT_WEAPON:
                        MafiaTutorialController.getInstance().setStep(MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_1);
                        break;
                     case MafiaTutorialController.TUT_STATE_SELECT_AMOUNT:
                        MafiaTutorialController.getInstance().setStep(MafiaTutorialController.TUT_STATE_GO_TO_GODFATHER);
                  }
               }
               if(_loc2_.hasInventorySlot)
               {
                  _loc3_ = !!_loc2_.hasSwappedAmount?uint(_loc2_.swappedAmount):uint(0);
                  MafiaModel.userData.armament.startDragAfterSwap(_loc2_.inventorySlot,_loc3_);
               }
               break;
            case PBEquipmentEquipArmamentResult.SOURCE_EMPTY:
            case PBEquipmentEquipArmamentResult.SOURCE_NOT_ENOUGH:
            case PBEquipmentEquipArmamentResult.WRONG_ITEM_TYPE:
            case PBEquipmentEquipArmamentResult.WRONG_SOURCE:
            case PBEquipmentEquipArmamentResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentEquipArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentEquipArmamentResponse;
      }
   }
}
