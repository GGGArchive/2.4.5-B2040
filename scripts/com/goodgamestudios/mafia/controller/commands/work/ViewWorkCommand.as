package com.goodgamestudios.mafia.controller.commands.work
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.work.viewwork.PBWorkViewWorkRequest;
   import com.goodgamestudios.mafia.controller.protobuf.work.viewwork.PBWorkViewWorkResponse;
   import com.goodgamestudios.mafia.controller.protobuf.work.viewwork.response.PBWorkViewWorkResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewWorkCommand extends BasicProtobufCommand
   {
       
      
      public function ViewWorkCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBWorkViewWorkRequest = new PBWorkViewWorkRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBWorkViewWorkResponse = param1 as PBWorkViewWorkResponse;
         switch(_loc2_.result)
         {
            case PBWorkViewWorkResult.OK:
            case PBWorkViewWorkResult.BUSY:
               MafiaModel.userData.workData.parseData(_loc2_);
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBWorkViewWorkRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBWorkViewWorkResponse;
      }
   }
}
