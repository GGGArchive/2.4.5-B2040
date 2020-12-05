package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.utils.ForumUtils;
   
   public class BasicOpenForumCommand extends SimpleCommand
   {
       
      
      public function BasicOpenForumCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         ForumUtils.navigateToForum(BasicController.getInstance().cryptedForumHash + (EnvGlobalsHandler.globals.isTest || EnvGlobalsHandler.globals.isLocal?"/1":""));
      }
   }
}
