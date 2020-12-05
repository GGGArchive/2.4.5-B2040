package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.CommonDialogNames;
   import com.goodgamestudios.basic.view.dialogs.BasicReconnectDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaReconnectDialog extends MafiaDialog
   {
      
      public static const NAME:String = CommonDialogNames.ReconnectDialog_NAME;
       
      
      public function MafiaReconnectDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.reconnectDialog.btn_reconnect.label = this.reconnectDialogProperties.buttonLabel_reconnect;
      }
      
      override protected function applyProperties() : void
      {
         this.reconnectDialog.txt_title.text = this.reconnectDialogProperties.title;
         this.reconnectDialog.txt_copy.text = this.reconnectDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.reconnectDialog.btn_reconnect:
               hide();
               if(this.reconnectDialogProperties.functionReconnect != null)
               {
                  this.reconnectDialogProperties.functionReconnect();
               }
         }
      }
      
      protected function get reconnectDialogProperties() : BasicReconnectDialogProperties
      {
         return properties as BasicReconnectDialogProperties;
      }
      
      protected function get reconnectDialog() : MafiaReconnect
      {
         return disp as MafiaReconnect;
      }
   }
}
