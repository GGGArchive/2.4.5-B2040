package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaDeactivateTresorItemDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaDeactivateTresorItemDialog extends MafiaStandardYesNoDialog
   {
      
      public static const NAME:String = "MafiaDeactivateTresorItemDialog";
       
      
      public function MafiaDeactivateTresorItemDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case standardDialog.btn_yes:
               hide();
               if(this.deactivateDialogProperties.functionYes != null)
               {
                  this.deactivateDialogProperties.functionYes(this.deactivateDialogProperties.location);
               }
               break;
            case standardDialog.btn_no:
               hide();
               if(this.deactivateDialogProperties.functionNo != null)
               {
                  this.deactivateDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get deactivateDialogProperties() : MafiaDeactivateTresorItemDialogProperties
      {
         return properties as MafiaDeactivateTresorItemDialogProperties;
      }
   }
}
