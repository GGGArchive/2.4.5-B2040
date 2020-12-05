package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.MafiaTutorialData;
   
   public class LSNCommand extends MafiaCommand
   {
       
      
      public function LSNCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_LOGIN_SET_NAME;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         param2.shift();
         var _loc3_:* = param2.shift() == 1;
         if(param1 == 0)
         {
            if(env.loginIsKeyBased)
            {
               if(!_loc3_)
               {
                  MafiaTutorialData.getInstance().tutorialShown = false;
                  MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_GET_ALLPLAYERDATA,[]);
                  layoutManager.onEndProgressbar();
               }
            }
            return true;
         }
         if(param1 == 4 || param1 == 5)
         {
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_NAME_OFFER,[param2.shift().split("#"),param1,_loc3_]));
         }
         return false;
      }
   }
}
