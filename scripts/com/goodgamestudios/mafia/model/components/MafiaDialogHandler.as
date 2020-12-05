package com.goodgamestudios.mafia.model.components
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   
   public class MafiaDialogHandler extends BasicDialogHandler
   {
       
      
      public function MafiaDialogHandler()
      {
         super();
      }
      
      public static function getInstance() : MafiaDialogHandler
      {
         if(!dialogHandler)
         {
            dialogHandler = new MafiaDialogHandler();
         }
         return dialogHandler as MafiaDialogHandler;
      }
      
      override public function set blockDialogs(param1:Boolean) : void
      {
         var _loc2_:Boolean = !param1 && super.blockDialogs;
         super.blockDialogs = param1;
         if(_loc2_)
         {
            BasicController.getInstance().dispatchEvent(new MafiaDialogEvent(MafiaDialogEvent.DIALOGS_UNBLOCKED));
         }
      }
   }
}
