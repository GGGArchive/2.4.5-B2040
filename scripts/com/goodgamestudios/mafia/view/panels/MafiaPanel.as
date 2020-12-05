package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class MafiaPanel extends BasicPanel
   {
      
      protected static const PANEL_INDEX_BUDDY:int = 10;
      
      protected static const PANEL_INDEX_TRAVEL:int = 15;
      
      protected static const PANEL_INDEX_TRAVELPROGRESS:int = 16;
      
      protected static const PANEL_INDEX_UNLOCKCITY:int = 17;
      
      protected static const PANEL_INDEX_ACTION:int = 20;
      
      protected static const PANEL_INDEX_MISSION_PROGRESS:int = 30;
      
      protected static const PANEL_INDEX_MISSION_SELECTION:int = 40;
      
      protected static const PANEL_INDEX_WORKSTART:int = 50;
      
      protected static const PANEL_INDEX_WORKPROGRESS:int = 50;
      
      protected static const PANEL_INDEX_WORKFINISHED:int = 50;
      
      protected static const PANEL_INDEX_LOGIN:int = 60;
      
      protected static const PANEL_INDEX_TIP:int = 80;
      
      protected static const PANEL_INDEX_REGISTER:int = 90;
      
      protected static const PANEL_INDEX_AVATAR_NAME_SELECTION:int = 91;
      
      protected static const PANEL_INDEX_TROOPMEMBER:int = 100;
      
      protected static const PANEL_INDEX_REVIEWTUTORIAL:int = 110;
      
      protected static const PANEL_INDEX_TUTORIAL:int = 120;
      
      protected static const PANEL_INDEX_HELP:int = 130;
      
      protected static const PANEL_INDEX_SLOT:int = 140;
      
      protected static const PANEL_INDEX_QUEST_PROGRESS_CHANGE:int = 150;
      
      protected static const PANEL_INDEX_QUESTLOG:int = 160;
      
      protected static const PANEL_YPOS:int = 345;
       
      
      public var index:int;
      
      public function MafiaPanel(param1:DisplayObject)
      {
         super(param1);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
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
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            if(this.env.hasNetworkBuddies)
            {
               disp.scaleY = disp.scaleX = disp.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               disp.scaleX = disp.scaleY = disp.stage.stageHeight / Constants_Basic.GAME_HEIGHT;
            }
            disp.x = this.layoutManager.gameNullPoint;
         }
      }
      
      protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_COMPLETED:
               this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
               unLockPanel();
               break;
            default:
               lockPanel();
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
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target && param1.target.toolTipText != null)
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
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target && param1.target.toolTipText != null)
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
               if(!this.layoutManager.dragManager.dragVO)
               {
                  this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
               }
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
            if((param1.target as MovieClip).enabled)
            {
               if(!this.layoutManager.dragManager.dragVO)
               {
                  this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               }
            }
         }
         if(param1.target is TextField)
         {
            if((param1.target as TextField).type == TextFieldType.INPUT)
            {
               this.layoutManager.customCursor.isEnabled = true;
            }
         }
      }
      
      override protected function onMouseUp(param1:MouseEvent) : void
      {
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
