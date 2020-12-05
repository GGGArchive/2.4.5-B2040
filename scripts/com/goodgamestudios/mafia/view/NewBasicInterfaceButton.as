package com.goodgamestudios.mafia.view
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public dynamic class NewBasicInterfaceButton extends MovieClip
   {
       
      
      protected var disableButton:NewBasicColorMatrix;
      
      protected var textField:TextField;
      
      protected var _selected:Boolean;
      
      protected var _minWidth:int = 70;
      
      protected var _label:String = "";
      
      public function NewBasicInterfaceButton()
      {
         this.disableButton = new NewBasicColorMatrix();
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.init();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
      }
      
      protected function onRemoveToStage(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      protected function init() : void
      {
         useHandCursor = true;
         buttonMode = true;
         mouseChildren = false;
         tabEnabled = false;
         this.textField = this.txt_label;
         this.label = " ";
         this.disableButton.desaturate();
         this.enableButton = enabled;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      public function set minWidth(param1:int) : void
      {
         this._minWidth = param1;
         this.updateTextfield();
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         this.updateTextfield();
      }
      
      protected function updateTextfield() : void
      {
         if(this.textField)
         {
            this.textField.text = this._label;
         }
         this.updateBackground();
      }
      
      protected function updateBackground() : void
      {
      }
      
      public function set enableButton(param1:Boolean) : void
      {
         enabled = param1;
         filters = !!param1?null:[this.disableButton.filter];
         this.updateTextfield();
      }
      
      public function selected() : void
      {
         this._selected = true;
      }
      
      public function deselected() : void
      {
         this._selected = false;
      }
      
      public function get isSelected() : Boolean
      {
         return this._selected;
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = 1;
         }
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = 1.1;
         }
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = 0.95;
         }
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.scaleX = this.scaleY = 1;
         }
      }
   }
}
