package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_CliendCommands;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.controller.clientCommands.MafiaStartProfilingCommand;
   import com.goodgamestudios.mafia.event.dialog.MafiaDialogEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.panels.MafiaPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTipPanel;
   import com.goodgamestudios.mafia.view.panels.MafiaTutorialPanel;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   import com.goodgamestudios.profiling.GoodgameProfiler;
   import com.goodgamestudios.utils.BrowserUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.utils.Dictionary;
   
   public class MafiaLayoutManager extends BasicLayoutManager
   {
      
      public static var stateDict:Dictionary = new Dictionary();
       
      
      public var actState:int;
      
      private var _previousState:int;
      
      private var _stateBeforeFight:int;
      
      private var tutPanel:MafiaTutorialPanel;
      
      private var tipPanel:MafiaTipPanel;
      
      private var tipLayer:Sprite;
      
      private var _profiler:GoodgameProfiler;
      
      public var tooltipManager:MafiaToolTipManager;
      
      public var blockGoldCashRank:Boolean;
      
      public function MafiaLayoutManager()
      {
         super();
         if(layoutManager)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : MafiaLayoutManager
      {
         if(!layoutManager)
         {
            layoutManager = new MafiaLayoutManager();
         }
         return layoutManager as MafiaLayoutManager;
      }
      
      public static function isFightState(param1:int) : Boolean
      {
         switch(param1)
         {
            case Constants_LayoutStates.STATE_CLAN_FIGHT:
            case Constants_LayoutStates.STATE_DUEL_FIGHT:
            case Constants_LayoutStates.STATE_DUEL_PREPARE:
            case Constants_LayoutStates.STATE_GANGWAR_FIGHT:
            case Constants_LayoutStates.STATE_POLICE_FIGHT:
            case Constants_LayoutStates.STATE_MISSION_FIGHT:
            case Constants_LayoutStates.STATE_REPLAY_FIGHT:
            case Constants_LayoutStates.STATE_SURVIVAL_FIGHT:
            case Constants_LayoutStates.STATE_TOURNAMENT_FIGHT:
            case Constants_LayoutStates.STATE_WANTED_FIGHT:
            case Constants_LayoutStates.STATE_CITYQUEST_BONUS_FIGHT:
               return true;
            default:
               return false;
         }
      }
      
      public function get stateBeforeFight() : int
      {
         return this._stateBeforeFight;
      }
      
      public function set stateBeforeFight(param1:int) : void
      {
         this._stateBeforeFight = param1;
      }
      
      override public function initialize(param1:BasicBackgroundComponent) : void
      {
         CommandController.instance.executeCommand(Constants_CliendCommands.COMMAND_INIT_LAYOUT_STATES);
         if(BrowserUtil.getBrowserName().indexOf("IE") != -1 && this.env.loginIsKeyBased)
         {
            param1.customCursor.hideForPerformance();
         }
         else
         {
            param1.customCursor.disp.filters = [new DropShadowFilter(3,45,0,0.5,5,5)];
         }
         super.initialize(param1);
         MafiaDataHolder.instance.layoutmanagerStarted = true;
         this.tipLayer = new Sprite();
         this.tooltipManager = new MafiaToolTipManager(tooltipLayer);
         layoutManager.addChild(backgroundLayer);
         layoutManager.addChild(screenLayer);
         layoutManager.addChild(panelLayer);
         layoutManager.addChild(dialogLayer);
         layoutManager.addChild(this.tipLayer);
         layoutManager.addChild(tutorialLayer);
         layoutManager.addChild(tooltipLayer);
         layoutManager.addChild(adminLayer);
         layoutManager.addChild(_mouseLayer);
         dragManager = new MafiaDragManager(_mouseLayer,0.9,0,0,0.2);
         createIdleLayer();
      }
      
      public function destroy() : void
      {
         this.state = 0;
      }
      
      override protected function onMouseUp(param1:Event) : void
      {
         super.onMouseUp(param1);
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               case MafiaTutorialController.TUT_STATE_DRAG_DYNAMITE:
               case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
                  MafiaTutorialController.getInstance().resetCurrentStep();
            }
         }
      }
      
      public function addTipPanel() : void
      {
         this.tipPanel = new MafiaTipPanel(new TipPanel());
         this.tipLayer.addChild(this.tipPanel.disp);
      }
      
      public function removeTipPanel() : void
      {
         if(this.tipPanel)
         {
            this.tipLayer.removeChild(this.tipPanel.disp);
            this.tipPanel.destroy();
            this.tipPanel = null;
         }
      }
      
      public function addTutorialArrow(param1:MovieClip) : void
      {
         tutorialLayer.addChild(param1);
         param1.scaleX = param1.scaleX * scaleFactor;
         param1.scaleY = param1.scaleY * scaleFactor;
      }
      
      public function addTutorialPanel() : void
      {
         this.tutPanel = new MafiaTutorialPanel(new TutorialPanel());
         tutorialLayer.addChild(this.tutPanel.disp);
         this.tutPanel.show();
         tutorialLayer.visible = true;
      }
      
      public function removeTutorialPanel() : void
      {
         if(this.tutPanel)
         {
            MovieClipHelper.clearMovieClip(tutorialLayer);
            this.tutPanel = null;
            tutorialLayer.visible = false;
         }
      }
      
      private function addProfiler() : void
      {
         if(!this._profiler)
         {
            this._profiler = new GoodgameProfiler(stage.stage,12,5);
            CommandController.instance.registerCommand(MafiaStartProfilingCommand.COMMAND_NAME,MafiaStartProfilingCommand);
            CommandController.instance.executeCommand(MafiaStartProfilingCommand.COMMAND_NAME);
         }
      }
      
      override public function set state(param1:int) : void
      {
         this.addProfiler();
         this.actState = param1;
         CommandController.instance.executeCommand(Constants_CliendCommands.COMMAND_EXECUTE_LAYOUT_STATES,[param1]);
         if(currentState != param1)
         {
            if(isFightState(param1) && !isFightState(currentState))
            {
               this.stateBeforeFight = currentState;
            }
            this._previousState = currentState;
            _currentState = param1;
            BasicController.getInstance().dispatchEvent(new MafiaDialogEvent(MafiaDialogEvent.CHANGE_LAYOUTSTATE,[currentState]));
         }
      }
      
      public function get isIngameState() : Boolean
      {
         return currentState > 10;
      }
      
      override public function toggleFullscreen() : void
      {
         if(stage.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.stage.displayState = StageDisplayState.NORMAL;
         }
         else
         {
            try
            {
               stage.stage.displayState = StageDisplayState.FULL_SCREEN;
               return;
            }
            catch(error:Error)
            {
               showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("fullscreenerror_msg_title"),MafiaModel.languageData.getTextById("fullscreenerror_msg_copy")));
               return;
            }
         }
      }
      
      override public function clearAllLayoutContent() : void
      {
         super.clearAllLayoutContent();
         this.clearToolTipLayer();
         this.tooltipManager.hideAdvancedTooltip();
         this.tooltipManager = new MafiaToolTipManager(tooltipLayer);
      }
      
      private function clearToolTipLayer() : void
      {
         this.tooltipManager.destroy();
         while(tooltipLayer.numChildren > 0)
         {
            tooltipLayer.removeChildAt(0);
         }
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      override public function showDialog(param1:String, param2:BasicProperties = null, param3:Sprite = null) : void
      {
         super.showDialog(param1,param2,param3);
         this.tooltipManager.hide();
         this.tooltipManager.hideAdvancedTooltip();
      }
      
      public function showSpecificPanel(param1:String, param2:BasicProperties = null) : void
      {
         var _loc3_:BasicPanel = null;
         if(panels[param1])
         {
            _loc3_ = panels[param1] as BasicPanel;
            _loc3_.setProperties(param2);
         }
         else
         {
            _loc3_ = this.createFlashComponent(param1) as BasicPanel;
            panels[param1] = _loc3_;
            _loc3_.setProperties(param2);
            panelLayer.addChild(_loc3_.disp);
         }
         _loc3_.show();
         this.sortPanels();
      }
      
      private function sortPanels() : void
      {
         var _loc2_:BasicPanel = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MafiaPanel = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in panels)
         {
            _loc1_.push(_loc2_);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length - 1)
         {
            _loc5_ = _loc3_ + 1;
            while(_loc5_ < _loc1_.length)
            {
               if(_loc1_[_loc3_].index > _loc1_[_loc5_].index)
               {
                  _loc6_ = _loc1_[_loc3_] as MafiaPanel;
                  _loc1_[_loc3_] = _loc1_[_loc5_];
                  _loc1_[_loc5_] = _loc6_;
               }
               _loc5_++;
            }
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            panelLayer.setChildIndex(_loc1_[_loc4_].disp,_loc4_);
            _loc4_++;
         }
      }
      
      override public function showPanel(param1:String, param2:BasicProperties = null) : void
      {
         super.showPanel(param1,param2);
         this.tooltipManager.hide();
         this.tooltipManager.hideAdvancedTooltip();
         if(panelLayer.numChildren < 2)
         {
            return;
         }
         this.sortPanels();
      }
      
      override protected function createFlashComponent(param1:String) : FlashUIComponent
      {
         return MafiaUIComponentCreator.createFlashComponent(param1);
      }
      
      public function get panelSprite() : Sprite
      {
         return panelLayer;
      }
      
      public function get mouseLayerSprite() : Sprite
      {
         return _mouseLayer;
      }
      
      public function get backgroundComponent() : MafiaBackgroundComponent
      {
         return _backgroundComponent as MafiaBackgroundComponent;
      }
      
      public function get profiler() : GoodgameProfiler
      {
         return this._profiler;
      }
      
      public function get previousState() : int
      {
         return this._previousState;
      }
   }
}
