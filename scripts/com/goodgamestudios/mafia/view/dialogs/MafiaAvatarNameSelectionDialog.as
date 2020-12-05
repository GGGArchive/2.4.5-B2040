package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaAvatarNameSelectionDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   
   public class MafiaAvatarNameSelectionDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaAvatarNameSelction";
       
      
      public function MafiaAvatarNameSelectionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         dispBounds = this.avatarNameSelction.getBounds(null);
      }
      
      override public function show() : void
      {
         super.show();
         this.avatarNameSelction.btn_close.label = MafiaModel.languageData.getTextById("MafiaAvatarNameselectionDialog_btn_change");
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:String = null;
         var _loc2_:NameSelectionText = null;
         this.avatarNameSelction.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarNameselectionDialog_title");
         this.avatarNameSelction.txt_copy.text = MafiaModel.languageData.getTextById("MafiaAvatarNameselectionDialog_copy");
         if(properties)
         {
            while(this.avatarNameSelction.mc_namesholder.numChildren > 0)
            {
               this.avatarNameSelction.mc_namesholder.removeChildAt(0);
            }
            for each(_loc1_ in this.avatarNameSelectionProperties.names)
            {
               _loc2_ = new NameSelectionText();
               _loc2_.txt_msg.text = _loc1_;
               _loc2_.name = _loc1_;
               _loc2_.addEventListener(MouseEvent.CLICK,this.onSelectName);
               _loc2_.addEventListener(MouseEvent.MOUSE_OVER,this.onOverSelectName);
               _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.onOutSelectName);
               _loc2_.txt_msg.width = _loc2_.txt_msg.textWidth + 5;
               _loc2_.y = this.avatarNameSelction.mc_namesholder.numChildren * _loc2_.height;
               _loc2_.mouseChildren = false;
               this.avatarNameSelction.mc_namesholder.addChild(_loc2_);
            }
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.avatarNameSelction.btn_close:
               hide();
         }
      }
      
      private function onOverSelectName(param1:MouseEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
         var _loc2_:NameSelectionText = param1.target as NameSelectionText;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_ = _loc2_.txt_msg.defaultTextFormat;
         _loc3_.underline = true;
         _loc3_.color = "0x296585";
         _loc2_.txt_msg.setTextFormat(_loc3_);
      }
      
      private function onOutSelectName(param1:MouseEvent) : void
      {
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         var _loc2_:NameSelectionText = param1.target as NameSelectionText;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_ = _loc2_.txt_msg.defaultTextFormat;
         _loc3_.underline = false;
         _loc3_.color = "0x453D28";
         _loc2_.txt_msg.setTextFormat(_loc3_);
      }
      
      private function onSelectName(param1:MouseEvent) : void
      {
         var _loc2_:NameSelectionText = param1.target as NameSelectionText;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_ = _loc2_.txt_msg.defaultTextFormat;
         _loc3_.underline = false;
         _loc3_.color = "0x453D28";
         _loc2_.txt_msg.setTextFormat(_loc3_);
         var _loc4_:String = String(param1.currentTarget.name);
         if(_loc4_ == null || _loc4_.length == 0)
         {
            return;
         }
         controller.dispatchEvent(new MafiaDialogEvent(MafiaDialogEvent.SELECT_NAME,[_loc4_]));
         hide();
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            disp.x = -dispBounds.left - dispBounds.width * 0.5 + (disp.stage.stageWidth - 100) * 0.5;
            disp.y = -dispBounds.top - dispBounds.height * 0.5 + (disp.stage.stageHeight - 100) * 0.5;
         }
      }
      
      protected function get avatarNameSelectionProperties() : MafiaAvatarNameSelectionDialogProperties
      {
         return properties as MafiaAvatarNameSelectionDialogProperties;
      }
      
      private function get avatarNameSelction() : MafiaAvatarNameSelection
      {
         return disp as MafiaAvatarNameSelection;
      }
   }
}
