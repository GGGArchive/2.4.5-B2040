package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.basic.model.components.BasicLanguageData;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MafiaFirstVisitNameSelection extends FlashUIComponent
   {
       
      
      private var _onNameSelectedFunction:Function;
      
      private var _target:DisplayObject;
      
      public function MafiaFirstVisitNameSelection(param1:MovieClip)
      {
         super(param1);
         this.avatarNameSelction.visible = false;
      }
      
      public function showNames(param1:Array, param2:int, param3:BasicLanguageData) : void
      {
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:NameSelectionText = null;
         this.avatarNameSelction.visible = true;
         updateAllTextFields();
         switch(param2)
         {
            case 4:
               _loc4_ = param3.getTextById("generic_register_namealreadyused");
               break;
            case 5:
               _loc4_ = param3.getTextById("generic_friends_invite_badword_copy");
         }
         this.avatarNameSelction.txt_title.text = _loc4_;
         this.updateTextField(this.avatarNameSelction.txt_title);
         this.avatarNameSelction.txt_title.width = 300;
         this.avatarNameSelction.txt_title.height = this.avatarNameSelction.txt_title.textHeight + 10;
         this.avatarNameSelction.mc_nameholder.y = this.avatarNameSelction.txt_title.height + this.avatarNameSelction.txt_title.y;
         this.avatarNameSelction.txt_title.x = this.avatarNameSelction.txt_title.width / -2 + 5;
         MovieClipHelper.clearMovieClip(this.avatarNameSelction.mc_nameholder);
         if(param1.length == 0)
         {
            return;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1[_loc5_];
            if(_loc6_)
            {
               _loc7_ = new NameSelectionText();
               _loc7_.txt_msg.text = _loc6_;
               _loc7_.name = _loc6_;
               _loc7_.txt_msg.textColor = 4537640;
               _loc7_.useHandCursor = true;
               _loc7_.buttonMode = true;
               _loc7_.addEventListener(MouseEvent.CLICK,this.onSelectName);
               _loc7_.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOverName);
               _loc7_.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOutName);
               _loc7_.y = _loc7_.height * 0.5 + this.avatarNameSelction.mc_nameholder.numChildren * _loc7_.height - 10;
               this.avatarNameSelction.mc_nameholder.addChild(_loc7_);
               this.updateTextField(_loc7_.txt_msg);
               _loc7_.txt_msg.width = _loc7_.txt_msg.textWidth + 10;
            }
            _loc5_++;
         }
         this.avatarNameSelction.mc_bg.height = this.avatarNameSelction.mc_nameholder.y + this.avatarNameSelction.mc_nameholder.numChildren * _loc7_.height + 5;
         this.avatarNameSelction.mc_bg.width = this.avatarNameSelction.txt_title.width + 10;
         show();
      }
      
      override public function destroy() : void
      {
         hide();
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
         hide();
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
      }
      
      public function set onNameSelectedFunction(param1:Function) : void
      {
         this._onNameSelectedFunction = param1;
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
      }
      
      public function setDisplayTarget(param1:DisplayObject) : void
      {
         this._target = param1;
         this.updatePosition();
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage && this._target)
         {
            disp.scaleX = disp.scaleY = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            disp.x = this._target.localToGlobal(new Point()).x + this._target.width * 0.5;
            disp.y = this._target.localToGlobal(new Point()).y + this._target.height;
            this._target.localToGlobal(new Point()).x;
         }
      }
      
      private function get avatarNameSelction() : NameSelection
      {
         return disp as NameSelection;
      }
      
      override protected function updateTextField(param1:TextField) : void
      {
         BasicLanguageFontManager.getInstance().changeFontByLanguage(param1);
      }
   }
}
