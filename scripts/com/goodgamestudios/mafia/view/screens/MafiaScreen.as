package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.screens.BasicScreen;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.SWFLoaderHelper;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.NewBasicInterfaceButton;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class MafiaScreen extends BasicScreen
   {
       
      
      protected var tutorialShown:Boolean = false;
      
      private const SCREENBACKGROUND:String = "ScreenBackground";
      
      private var _urlString:String;
      
      private var _bgLoad:Boolean;
      
      public function MafiaScreen(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1);
         this._bgLoad = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.controller.addEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         this.controller.addEventListener(MafiaTutorialEvent.TUTORIAL_RESET_CURRENT_STEP,this.onResetTutorialStep);
         this.controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_DATA,this.onChangeUserData);
      }
      
      override public function show() : void
      {
         super.show();
         if(this._bgLoad)
         {
            this.loadBackground(this.screenBackgroundId);
         }
         if(disp["backgroundHolder"])
         {
            MovieClipHelper.playAllMovies(disp["backgroundHolder"]);
         }
         updateAllTextFields();
      }
      
      protected function loadBackground(param1:String) : void
      {
         if(param1 == Constants_Background.BG_DEFAULT.toString())
         {
            return;
         }
         this._urlString = this.getScreenBackgroundSwfUrl(param1);
         if(SWFLoaderHelper.instance.isSWFLoaded(this._urlString))
         {
            this.fillBackground(SWFLoaderHelper.instance.getCompletedLoader(this._urlString));
         }
         else
         {
            SWFLoaderHelper.instance.loadSWF(this._urlString,this.onLoadBackgroundComplete);
         }
      }
      
      protected function get screenBackgroundId() : String
      {
         return "";
      }
      
      private function fillBackground(param1:Loader) : void
      {
         var _loc3_:MovieClip = null;
         var _loc2_:MovieClip = param1.content as MovieClip;
         _loc2_.mouseChildren = _loc2_.mouseEnabled = false;
         if(param1)
         {
            _loc3_ = disp["backgroundHolder"] as MovieClip;
            MovieClipHelper.clearMovieClip(_loc3_);
            _loc2_.cacheAsBitmap = true;
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
            _loc3_.addChild(_loc2_);
         }
         else
         {
            trace("Kein Loader gefunden");
         }
      }
      
      protected final function onLoadBackgroundComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this.fillBackground(_loc2_.loader);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.removeEvents();
         if(disp["backgroundHolder"])
         {
            MovieClipHelper.stopAllMovies(disp["backgroundHolder"]);
         }
      }
      
      override public function destroy() : void
      {
         this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
         this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_RESET_CURRENT_STEP,this.onResetTutorialStep);
         this.controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_DATA,this.onChangeUserData);
         disp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         disp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.removeEvents();
         super.destroy();
      }
      
      protected function removeEvents() : void
      {
      }
      
      protected function onResetTutorialStep(param1:MafiaTutorialEvent) : void
      {
      }
      
      protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_COMPLETED:
               this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE,this.onTutorialEvent);
               this.controller.removeEventListener(MafiaTutorialEvent.TUTORIAL_RESET_CURRENT_STEP,this.onResetTutorialStep);
         }
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
      
      protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
      }
      
      protected function get controller() : BasicController
      {
         return BasicController.getInstance();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
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
         if(BasicToolTipManager.TOOLTIP_LABEL in param1.target)
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
         if(param1.target is MovieClip && (param1.target as MovieClip).name.indexOf("btn_") >= 0)
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
         if(param1.target is MovieClip && (param1.target as MovieClip).name.indexOf("btn_") >= 0)
         {
            if(!this.layoutManager.dragManager.dragVO)
            {
               this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
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
      
      protected final function getScreenBackgroundSwfUrl(param1:String) : String
      {
         return this.env.baseURL + "/backgrounds/" + this.SCREENBACKGROUND + "_" + param1 + ".swf";
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
