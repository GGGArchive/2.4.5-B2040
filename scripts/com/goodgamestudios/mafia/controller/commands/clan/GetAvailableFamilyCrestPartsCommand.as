package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufVOTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.family.PBFamilyCrestPart;
   import com.goodgamestudios.mafia.controller.protobuf.family.crest.availablecrestparts.PBFamilyCrestAvailableCrestPartsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.crest.availablecrestparts.PBFamilyCrestAvailableCrestPartsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.crest.availablecrestparts.response.PBFamilyCrestAvailableCrestPartsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCustomizeCrestDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaCustomizeCrestDialogProperties;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestPartVO;
   import com.netease.protobuf.Message;
   
   public class GetAvailableFamilyCrestPartsCommand extends BasicProtobufCommand
   {
       
      
      public function GetAvailableFamilyCrestPartsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFamilyCrestAvailableCrestPartsRequest = new PBFamilyCrestAvailableCrestPartsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc3_:Vector.<FamilyCrestPartVO> = null;
         var _loc4_:PBFamilyCrestPart = null;
         var _loc2_:PBFamilyCrestAvailableCrestPartsResponse = param1 as PBFamilyCrestAvailableCrestPartsResponse;
         switch(_loc2_.result)
         {
            case PBFamilyCrestAvailableCrestPartsResult.OK:
               _loc3_ = new Vector.<FamilyCrestPartVO>();
               for each(_loc4_ in _loc2_.parts)
               {
                  _loc3_.push(ProtobufVOTranslator.translateProtoFamilyCrestPart(_loc4_));
               }
               MafiaModel.userData.userClan.parseAvailableCrestParts(_loc3_);
               if(MafiaLayoutManager.getInstance().currentState == Constants_LayoutStates.STATE_USERCLAN && MafiaModel.userData.userClan.familyCrest != null)
               {
                  MafiaDialogHandler.getInstance().registerDialogs(MafiaCustomizeCrestDialog.NAME,new MafiaCustomizeCrestDialogProperties(MafiaModel.userData.userClan.familyCrest.copy()),true,BasicDialogHandler.PRIORITY_TOP);
               }
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyCrestAvailableCrestPartsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyCrestAvailableCrestPartsResponse;
      }
   }
}
