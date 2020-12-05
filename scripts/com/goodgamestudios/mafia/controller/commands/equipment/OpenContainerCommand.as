package com.goodgamestudios.mafia.controller.commands.equipment
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_ItemContainer;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.PBEquipmentOpenContainerRequest;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.PBEquipmentOpenContainerResponse;
   import com.goodgamestudios.mafia.controller.protobuf.equipment.opencontainer.response.PBEquipmentOpenContainerResult;
   import com.goodgamestudios.mafia.event.model.MafiaOpenItemContainerEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.netease.protobuf.Message;
   
   public class OpenContainerCommand extends BasicProtobufCommand
   {
       
      
      public function OpenContainerCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint) : void
      {
         var _loc2_:PBEquipmentOpenContainerRequest = new PBEquipmentOpenContainerRequest();
         _loc2_.slot = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBEquipmentOpenContainerResponse = null;
         var _loc3_:int = 0;
         var _loc4_:ItemVO = null;
         var _loc5_:String = null;
         var _loc6_:BasicStandardOkDialogProperties = null;
         var _loc7_:ItemVO = null;
         MafiaModel.userData.unlockAllItems();
         _loc2_ = param1 as PBEquipmentOpenContainerResponse;
         switch(_loc2_.result)
         {
            case PBEquipmentOpenContainerResult.OK:
               _loc3_ = _loc2_.containerSlotId;
               if(_loc2_.stacked)
               {
                  _loc7_ = MafiaItemData.parseItem(_loc2_.stacked,ItemLocation.None,0);
                  MafiaLayoutManager.getInstance().showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_merge_copy_1",[_loc7_.amount,_loc7_.name])));
                  _loc3_ = _loc7_.slotId;
               }
               _loc4_ = MafiaItemData.parseItem(_loc2_.item,ItemLocation.Inventory,_loc3_);
               controller.dispatchEvent(new MafiaOpenItemContainerEvent(MafiaOpenItemContainerEvent.CONTAINER_OPENED,Constants_ItemContainer.MYSTERY_BOX,_loc4_,_loc2_.containerSlotId));
               return true;
            case PBEquipmentOpenContainerResult.ITEM_AMOUNT_LIMIT_REACHED:
               _loc5_ = NumberStringHelper.groupString(9999,MafiaModel.languageData.getTextById);
               _loc6_ = new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_copy_1",[_loc5_]));
               MafiaLayoutManager.getInstance().showDialog(MafiaStandardOkDialog.NAME,_loc6_);
               break;
            case PBEquipmentOpenContainerResult.MERGING_STACKS_NOT_POSSIBLE:
               break;
            case PBEquipmentOpenContainerResult.NO_CONTAINER_AT_SLOT:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBEquipmentOpenContainerRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBEquipmentOpenContainerResponse;
      }
   }
}
