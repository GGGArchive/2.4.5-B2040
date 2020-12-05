package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.dialogs.BasicDialog;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class MafiaDialog extends BasicDialog
   {
       
      
      protected var dropShadow:DropShadowFilter;
      
      public function MafiaDialog(param1:Sprite)
      {
         this.dropShadow = new DropShadowFilter(3,45,0,0.3);
         super(param1);
         backgroundColor = 3351578;
         backgroundAlpha = 0.2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         param1.filters = [this.dropShadow];
         this.controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_DATA,this.onChangeUserData);
         this.controller.addEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
      }
      
      override public function destroy() : void
      {
         this.controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_DATA,this.onChangeUserData);
         this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         super.destroy();
         this.removeEvents();
      }
      
      override public function hide() : void
      {
         super.hide();
         this.removeEvents();
      }
      
      protected function removeEvents() : void
      {
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function get basicDialogHandler() : BasicDialogHandler
      {
         return MafiaDialogHandler.getInstance();
      }
      
      protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_COMPLETED:
               this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         }
      }
      
      override protected function onResize(param1:Event) : void
      {
         super.onResize(param1);
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Number = NaN;
         if(disp && disp.stage)
         {
            if(this.env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
               _loc1_ = 100 * disp.scaleY;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
               _loc1_ = 0;
            }
            disp.x = this.layoutManager.gameNullPoint + -dispBounds.left - dispBounds.width * 0.5 + Constants_Basic.GAME_WIDTH * disp.scaleX * 0.5;
            disp.y = -dispBounds.bottom * disp.scaleY + dispBounds.height * 0.5 * disp.scaleY + disp.stage.stageHeight * 0.5;
         }
      }
      
      protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is NewBasicInterfaceButton)
         {
            BasicController.getInstance().soundController.playSoundEffect(MafiaSoundController.SND_BUTTON);
         }
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         BasicController.getInstance().dispatchEvent(new MafiaDialogEvent(MafiaDialogEvent.MOUSE_ON_DIALOG));
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target && param1.target.toolTipText)
         {
            this.layoutManager.tooltipManager.show(param1.target.toolTipText,param1.target as DisplayObject);
            return;
         }
         if(BasicToolTipManager.TOOLTIP_VO in param1.target)
         {
            this.layoutManager.tooltipManager.showAdvancedTooltip(param1.target.toolTipVO,param1.target as DisplayObject);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
         {
            this.layoutManager.tooltipManager.hide();
            return;
         }
         if(BasicToolTipManager.TOOLTIP_VO in param1.target)
         {
            this.layoutManager.tooltipManager.hideAdvancedTooltip();
         }
      }
      
      override protected function onCursorOver(param1:MouseEvent) : void
      {
         if(param1.target is NewBasicInterfaceButton && (param1.target as MovieClip).name.indexOf("btn_") >= 0)
         {
            if((param1.target as MovieClip).enabled)
            {
               this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            }
         }
         if(param1.target is TextField)
         {
            if((param1.target as TextField).type == TextFieldType.INPUT)
            {
               this.layoutManager.customCursor.isEnabled = false;
            }
         }
      }
      
      override protected function onCursorOut(param1:MouseEvent) : void
      {
         if(param1.target is NewBasicInterfaceButton && (param1.target as MovieClip).name.indexOf("btn_") >= 0)
         {
            this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         }
         if(param1.target is TextField)
         {
            if((param1.target as TextField).type == TextFieldType.INPUT)
            {
               this.layoutManager.customCursor.isEnabled = true;
            }
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
