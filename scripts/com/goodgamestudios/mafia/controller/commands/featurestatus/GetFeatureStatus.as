package com.goodgamestudios.mafia.controller.commands.featurestatus
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.PBFeaturestatusGetFeatureStatusRequest;
   import com.goodgamestudios.mafia.controller.protobuf.featurestatus.getfeaturestatus.PBFeaturestatusGetFeatureStatusResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GetFeatureStatus extends BasicProtobufCommand
   {
       
      
      public function GetFeatureStatus()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBFeaturestatusGetFeatureStatusRequest = new PBFeaturestatusGetFeatureStatusRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFeaturestatusGetFeatureStatusResponse = param1 as PBFeaturestatusGetFeatureStatusResponse;
         if(_loc2_.featureStatus)
         {
            MafiaModel.userData.featureStatusData.parseFeatureStatus(_loc2_.featureStatus);
            return true;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFeaturestatusGetFeatureStatusRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFeaturestatusGetFeatureStatusResponse;
      }
   }
}
