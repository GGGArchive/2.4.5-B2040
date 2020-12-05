package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.panels.MafiaPanel;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MafiaAvatarNameSelectionPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaAvatarNameSelectionPanel";
       
      
      private var names:Array;
      
      private var _onNameSelectedFunction:Function;
      
      private var _target:DisplayObject;
      
      public function MafiaAvatarNameSelectionPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_AVATAR_NAME_SELECTION;
      }
      
      public function showNames(param1:Array, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:NameSelectionText = null;
         this.names = [];
         updateAllTextFields();
         this.avatarNameSelction.txt_title.width = Constants_Basic.GAME_WIDTH;
         switch(param2)
         {
            case 4:
               _loc3_ = MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_9");
               break;
            case 5:
               _loc3_ = MafiaModel.languageData.getTextById("generic_friends_invite_badword_copy");
         }
         this.avatarNameSelction.txt_title.text = _loc3_;
         updateTextField(this.avatarNameSelction.txt_title);
         this.avatarNameSelction.txt_title.width = 300;
         this.avatarNameSelction.txt_title.height = this.avatarNameSelction.txt_title.textHeight + 10;
         this.avatarNameSelction.mc_nameholder.y = this.avatarNameSelction.txt_title.height + this.avatarNameSelction.txt_title.y;
         this.avatarNameSelction.txt_title.x = this.avatarNameSelction.txt_title.width / -2 + 5;
         MovieClipHelper.clearMovieClip(this.avatarNameSelction.mc_nameholder);
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               _loc5_ = new NameSelectionText();
               _loc5_.txt_msg.text = _loc4_;
               _loc5_.name = _loc4_;
               _loc5_.txt_msg.textColor = 4537640;
               _loc5_.useHandCursor = true;
               _loc5_.buttonMode = true;
               _loc5_.addEventListener(MouseEvent.CLICK,this.onSelectName);
               _loc5_.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverName);
               _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOutName);
               _loc5_.y = _loc5_.height * 0.5 + this.avatarNameSelction.mc_nameholder.numChildren * _loc5_.height - 10;
               this.names.push(_loc5_);
               this.avatarNameSelction.mc_nameholder.addChild(_loc5_);
               updateTextField(_loc5_.txt_msg);
               _loc5_.txt_msg.width = _loc5_.txt_msg.textWidth + 10;
            }
         }
         this.avatarNameSelction.mc_bg.height = this.avatarNameSelction.mc_nameholder.y + this.avatarNameSelction.mc_nameholder.numChildren * _loc5_.height + 5;
         this.avatarNameSelction.mc_bg.width = this.avatarNameSelction.txt_title.width + 10;
         this.show();
      }
      
      override public function hide() : void
      {
         var _loc1_:NameSelectionText = null;
         if(disp)
         {
            for each(_loc1_ in this.names)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onSelectName);
               _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOverName);
               _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOutName);
            }
            this.names = [];
            super.hide();
         }
      }
      
      override public function show() : void
      {
         if(disp)
         {
            if(disp.stage)
            {
               disp.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
               disp.stage.addEventListener(Event.RESIZE,onResize);
            }
            onResize(null);
            disp.visible = true;
            updateAllTextFields();
         }
      }
      
      override public function destroy() : void
      {
         this.hide();
         MovieClipHelper.clearMovieClip(this.avatarNameSelction.mc_nameholder);
         super.destroy();
      }
      
      private function onSelectName(param1:MouseEvent) : void
      {
         var _loc2_:String = String(param1.currentTarget.name);
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         this._onNameSelectedFunction(param1.currentTarget.name);
         this.hide();
      }
      
      private function onRollOverName(param1:MouseEvent) : void
      {
         if(param1.target.name != "txt_msg")
         {
            return;
         }
         var _loc2_:TextFormat = (param1.target as TextField).getTextFormat();
         _loc2_.underline = true;
         _loc2_.color = 255;
         (param1.target as TextField).setTextFormat(_loc2_);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
      }
      
      public function set onNameSelectedFunction(param1:Function) : void
      {
         this._onNameSelectedFunction = param1;
      }
      
      public function setDisplayTarget(param1:DisplayObject) : void
      {
         this._target = param1;
         this.updatePosition();
      }
      
      private function onRollOutName(param1:MouseEvent) : void
      {
         if(param1.target.name != "txt_msg")
         {
            return;
         }
         var _loc2_:TextFormat = (param1.target as TextField).getTextFormat();
         _loc2_.underline = false;
         _loc2_.color = 4537640;
         (param1.target as TextField).setTextFormat(_loc2_);
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage && this._target)
         {
            if(env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            disp.x = this._target.localToGlobal(new Point()).x + this._target.width * 0.5;
            disp.y = this._target.localToGlobal(new Point()).y + this._target.height;
         }
      }
      
      private function get avatarNameSelction() : NameSelection
      {
         return disp as NameSelection;
      }
   }
}
