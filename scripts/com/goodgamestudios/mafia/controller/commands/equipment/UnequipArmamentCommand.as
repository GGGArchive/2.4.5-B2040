package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.PBEquipmentUnequipArmamentRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.PBEquipmentUnequipArmamentResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.unequiparmament.response.PBEquipmentUnequipArmamentResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.netease.protobuf.Message;
   
   public class UnequipArmamentCommand extends BasicProtobufCommand
   {
       
      
      public function UnequipArmamentCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:PBEquipmentUnequipArmamentRequest = new PBEquipmentUnequipArmamentRequest();
         _loc4_.sourceX = param2;
         _loc4_.sourceY = param3;
         _loc4_.target = param1;
         _loc4_.armamentNumber = MafiaModel.userData.armamentPresetData.activeArmament;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:ItemVO = null;
         MafiaModel.userData.unlockAllItems();
         var _loc2_:PBEquipmentUnequipArmamentResponse = param1 as PBEquipmentUnequipArmamentResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentUnequipArmamentResult.OK:
               if(_loc2_.stacked)
               {
                  _loc3_ = MafiaItemData.parseItem(_loc2_.stacked,ItemLocation.None,0);
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_copy_1",[_loc3_.amount,_loc3_.name])));
               }
               return true;
            case PBEquipmentUnequipArmamentResult.ARMAMENT_LOCKED:
            case PBEquipmentUnequipArmamentResult.SOURCE_EMPTY:
            case PBEquipmentUnequipArmamentResult.WRONG_ITEM_TYPE:
            case PBEquipmentUnequipArmamentResult.WRONG_SOURCE:
            case PBEquipmentUnequipArmamentResult.WRONG_TARGET:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentUnequipArmamentRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentUnequipArmamentResponse;
      }
   }
}
