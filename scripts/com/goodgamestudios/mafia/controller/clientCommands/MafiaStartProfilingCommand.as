package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.profiling.GoodgameProfiler;
   
   public class MafiaStartProfilingCommand extends SimpleCommand
   {
      
      public static const COMMAND_NAME:String = "MafiaStartProfilingCommand";
       
      
      public function MafiaStartProfilingCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:GoodgameProfiler = MafiaLayoutManager.getInstance().profiler;
         CommandController.instance.registerCommand(MafiaProfilerProvisionCommand.COMMAND_NAME,MafiaProfilerProvisionCommand);
         _loc2_.addCommandToStack(MafiaProfilerProvisionCommand.COMMAND_NAME);
         _loc2_.startProfiling();
      }
   }
}
