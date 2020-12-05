package com.goodgamestudios.mafia.controller.clientCommands
{
   import com.adobe.utils.DictionaryUtil;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.states.MafiaLayoutState;
   
   public class MafiaExecuteLayoutStateCommand extends SimpleCommand
   {
       
      
      public function MafiaExecuteLayoutStateCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc3_:MafiaLayoutState = null;
         var _loc2_:int = int(param1[0]);
         if(DictionaryUtil.containsKey(MafiaLayoutManager.stateDict,_loc2_))
         {
            _loc3_ = MafiaLayoutManager.stateDict[_loc2_];
            _loc3_.executeState();
         }
         else
         {
            trace("LAYOUT STATE UNKNOWN: " + _loc2_);
         }
      }
   }
}
