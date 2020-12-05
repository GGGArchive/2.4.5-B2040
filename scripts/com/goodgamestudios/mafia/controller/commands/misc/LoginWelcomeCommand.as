package com.goodgamestudios.mafia.controller.commands.misc
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.PBMiscLoginWelcomeRequest;
   import com.goodgamestudios.mafia.controller.protobuf.misc.loginwelcome.PBMiscLoginWelcomeResponse;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class LoginWelcomeCommand extends BasicProtobufCommand
   {
       
      
      public function LoginWelcomeCommand()
      {
         super();
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMiscLoginWelcomeResponse = param1 as PBMiscLoginWelcomeResponse;
         if(_loc2_.reward)
         {
            MafiaModel.userData.welcomeData.parseWelcomeDataPB(_loc2_);
            return true;
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMiscLoginWelcomeRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMiscLoginWelcomeResponse;
      }
   }
}
