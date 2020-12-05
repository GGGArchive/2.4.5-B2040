package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   
   public class MafiaProfilerProvisionCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "MafiaProfilerProvisionCommand";
       
      
      public function MafiaProfilerProvisionCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(this.layoutManager.customCursor.isEnabled)
         {
            this.layoutManager.customCursor.hideForPerformance();
         }
      }
      
      private function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
