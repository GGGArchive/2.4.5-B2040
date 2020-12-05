package com.goodgamestudios.mafia.controller.commands.fight
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.commands.gangwars.ShowGangWarsCommand;
   import com.goodgamestudios.mafia.controller.protobuf.fight.selectcityfightitem.PBFightSelectCityFightItemRequest;
   import com.goodgamestudios.mafia.controller.protobuf.fight.selectcityfightitem.PBFightSelectCityFightItemResponse;
   import com.goodgamestudios.mafia.controller.protobuf.fight.selectcityfightitem.response.PBFightSelectCityFightItemResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.netease.protobuf.Message;
   
   public class SelectCityFightItemCommand extends BasicProtobufCommand
   {
       
      
      public function SelectCityFightItemCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:int) : void
      {
         var _loc3_:PBFightSelectCityFightItemRequest = new PBFightSelectCityFightItemRequest();
         _loc3_.districtId = param1;
         _loc3_.itemSlot = param2;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:String = null;
         var _loc2_:PBFightSelectCityFightItemResponse = param1 as PBFightSelectCityFightItemResponse;
         switch(_loc2_.result)
         {
            case PBFightSelectCityFightItemResult.OK:
               ShowGangWarsCommand.sendCommand();
               return true;
            case PBFightSelectCityFightItemResult.ITEM_NOT_FOUND:
               break;
            case PBFightSelectCityFightItemResult.ITEM_AMOUNT_LIMIT_REACHED:
               _loc3_ = NumberStringHelper.groupString(9999,MafiaModel.languageData.getTextById);
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_title"),MafiaModel.languageData.getTextById("MafiaStackableDialog_limit_copy_1",[_loc3_])));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFightSelectCityFightItemRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFightSelectCityFightItemResponse;
      }
   }
}
