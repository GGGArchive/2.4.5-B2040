package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.controller.commands.CMTCommand;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.commanding.SimpleCommand;
   
   public class BasicShowComaTeaserCommand extends SimpleCommand
   {
       
      
      public function BasicShowComaTeaserCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:int = param1[0];
         var _loc3_:String = param1[2];
         var _loc4_:String = param1[3];
         if(_loc2_ == CMTCommand.TEASERTYPE_WARNING)
         {
            BasicLayoutManager.getInstance().showAdminDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(_loc3_,_loc4_));
         }
         else if(BasicLayoutManager.gameState == BasicLayoutManager.STATE_LOGIN)
         {
            BasicDialogHandler.getInstance().registerDialogs(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(_loc3_,_loc4_));
         }
         else
         {
            BasicLayoutManager.getInstance().showAdminDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(_loc3_,_loc4_));
         }
      }
   }
}
