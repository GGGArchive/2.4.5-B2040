package com.goodgamestudios.basic.view
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.dialogs.BasicDialog;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.panels.BasicPanel;
   import com.goodgamestudios.basic.view.screens.BasicIdleScreen;
   import com.goodgamestudios.basic.view.screens.BasicScreen;
   import com.goodgamestudios.graphics.animation.AnimatedDisplayObject;
   import com.goodgamestudios.utils.MouseWheel;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class BasicLayoutManager extends Sprite
   {
      
      public static const STATE_PRELOAD_INIT:int = -1;
      
      public static const STATE_PRELOAD_CONNECTED:int = 0;
      
      public static const STATE_CONNECT:int = 1;
      
      public static const STATE_LOGIN:int = 2;
      
      public static const STATE_AVATAR_CREATION:int = 3;
      
      public static const STATE_LOAD_ITEMS:int = 4;
      
      public static const STATE_REGISTRATION:int = 5;
      
      public static const STATE_STARTSCREEN:int = 6;
      
      public static const QUALITY_HIGH:int = 0;
      
      public static const QUALITY_MEDIUM:int = 1;
      
      public static const QUALITY_LOW:int = 2;
      
      public static var gameState:int = 99;
      
      protected static var layoutManager:BasicLayoutManager;
       
      
      protected var backgroundLayer:Sprite;
      
      protected var _backgroundComponent:BasicBackgroundComponent;
      
      protected var screenLayer:Sprite;
      
      protected var adminLayer:Sprite;
      
      protected var dialogLayer:Sprite;
      
      protected var panelLayer:Sprite;
      
      public var tutorialLayer:Sprite;
      
      protected var tooltipLayer:Sprite;
      
      protected var _mouseLayer:Sprite;
      
      protected var idleHolderLayer:Sprite;
      
      protected var panels:Dictionary;
      
      protected var screens:Dictionary;
      
      protected var dialogs:Vector.<BasicDialog>;
      
      protected var _currentState:int;
      
      private var _initialized:Boolean;
      
      private var mouseWheel:MouseWheel;
      
      private var animatedDisplayObjects:Vector.<AnimatedDisplayObject>;
      
      private var animatedFlashUIComponents:Vector.<AnimatedFlashUIComponent>;
      
      public var customCursor:BasicCustomCursor;
      
      public var dragManager:BasicDragManager;
      
      private var idleScreen:BasicIdleScreen;
      
      public function BasicLayoutManager()
      {
         super();
         this._initialized = false;
         if(layoutManager)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function getInstance() : BasicLayoutManager
      {
         if(!layoutManager)
         {
            throw new Error("LayoutManager is not initialized!");
         }
         return layoutManager;
      }
      
      protected function onMouseUp(param1:Event) : void
      {
         if(this.dragManager)
         {
            this.dragManager.stopDragging();
         }
      }
      
      public function initialize(param1:BasicBackgroundComponent) : void
      {
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.animatedFlashUIComponents = new Vector.<AnimatedFlashUIComponent>();
         this.animatedDisplayObjects = new Vector.<AnimatedDisplayObject>();
         this.dialogs = new Vector.<BasicDialog>();
         this.panels = new Dictionary();
         this.screens = new Dictionary();
         this._currentState = 0;
         this.adminLayer = new Sprite();
         this.screenLayer = new Sprite();
         this.panelLayer = new Sprite();
         this.dialogLayer = new Sprite();
         this.tutorialLayer = new Sprite();
         this.tooltipLayer = new Sprite();
         this._mouseLayer = new Sprite();
         this._mouseLayer.mouseChildren = false;
         this._mouseLayer.mouseEnabled = false;
         this.backgroundLayer = new Sprite();
         this._backgroundComponent = param1;
         if(this._backgroundComponent)
         {
            (this._backgroundComponent.disp as Sprite).mouseEnabled = true;
            (this._backgroundComponent.disp as Sprite).mouseChildren = true;
            this.backgroundLayer.addChild(this._backgroundComponent.disp);
            if(this._backgroundComponent.customCursor)
            {
               this.customCursor = this._backgroundComponent.customCursor;
               this._mouseLayer.addChild(this.customCursor.disp);
            }
         }
         this._initialized = true;
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      public function set state(param1:int) : void
      {
         switch(param1)
         {
            case STATE_LOAD_ITEMS:
               this.hideAllDialogs();
               this.hideAllPanels();
               this.showBackgroundLayer();
               this._backgroundComponent.showProgressBar();
               gameState = STATE_LOAD_ITEMS;
               break;
            case STATE_CONNECT:
               this.hideAllDialogs();
               this.hideAllPanels();
               this.showBackgroundLayer();
               break;
            case STATE_LOGIN:
               this.hideAllPanels();
               this.showBackgroundLayer();
               gameState = STATE_LOGIN;
         }
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:AnimatedDisplayObject = null;
         var _loc3_:AnimatedFlashUIComponent = null;
         for each(_loc2_ in this.animatedDisplayObjects)
         {
            _loc2_.playForward();
         }
         for each(_loc3_ in this.animatedFlashUIComponents)
         {
            _loc3_.onEnterFrameUpdate();
         }
      }
      
      public function addAniDo(param1:AnimatedDisplayObject) : void
      {
         this.animatedDisplayObjects.push(param1);
      }
      
      public function addAnimFlashUIComponent(param1:AnimatedFlashUIComponent) : void
      {
         this.animatedFlashUIComponents.push(param1);
      }
      
      public function removeAniDo(param1:AnimatedDisplayObject) : void
      {
         var _loc3_:AnimatedDisplayObject = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.animatedDisplayObjects.length)
         {
            _loc3_ = this.animatedDisplayObjects[_loc2_] as AnimatedDisplayObject;
            if(_loc3_ == param1)
            {
               this.animatedDisplayObjects.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      public function removeAnimFlashUIComponent(param1:FlashUIComponent) : void
      {
         var _loc3_:FlashUIComponent = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.animatedFlashUIComponents.length)
         {
            _loc3_ = this.animatedFlashUIComponents[_loc2_] as FlashUIComponent;
            if(_loc3_ == param1)
            {
               this.animatedFlashUIComponents.splice(_loc2_,1);
            }
            _loc2_++;
         }
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.mouseWheel = new MouseWheel(stage);
      }
      
      public function changeQualityLevel(param1:int) : void
      {
         switch(param1)
         {
            default:
            case QUALITY_HIGH:
               layoutManager.stage.quality = StageQuality.BEST;
               break;
            case QUALITY_MEDIUM:
               layoutManager.stage.quality = StageQuality.MEDIUM;
               break;
            case QUALITY_LOW:
               layoutManager.stage.quality = StageQuality.LOW;
         }
      }
      
      protected function getDialogIndex(param1:String) : int
      {
         var _loc3_:BasicDialog = null;
         var _loc4_:String = null;
         var _loc5_:Class = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.dialogs.length)
         {
            _loc3_ = this.dialogs[_loc2_];
            _loc4_ = getQualifiedClassName(_loc3_);
            _loc5_ = Class(getDefinitionByName(_loc4_));
            _loc4_ = _loc5_.NAME;
            if(param1 == _loc4_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function getScreen(param1:String) : BasicScreen
      {
         if(param1 in this.screens)
         {
            return this.screens[param1];
         }
         return null;
      }
      
      public function getPanel(param1:String) : BasicPanel
      {
         if(param1 in this.panels)
         {
            return this.panels[param1];
         }
         return null;
      }
      
      public function getDialog(param1:Class) : BasicDialog
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function showDialog(param1:String, param2:BasicProperties = null, param3:Sprite = null) : void
      {
         var _loc4_:BasicDialog = null;
         if(param3 == null)
         {
            param3 = this.dialogLayer;
         }
         var _loc5_:int = this.getDialogIndex(param1);
         if(_loc5_ >= 0)
         {
            _loc4_ = this.dialogs[_loc5_];
         }
         if(_loc4_ == null)
         {
            _loc4_ = this.createFlashComponent(param1) as BasicDialog;
            this.dialogs.push(_loc4_);
         }
         _loc4_.setProperties(param2);
         if(_loc4_.disp.parent != param3)
         {
            param3.addChild(_loc4_.disp);
         }
         param3.setChildIndex(_loc4_.disp,param3.numChildren - 1);
         _loc4_.show();
      }
      
      public function showAdminDialog(param1:String, param2:BasicProperties = null) : void
      {
         this.showDialog(param1,param2,this.adminLayer);
      }
      
      public function hideAllDialogs() : void
      {
         var _loc1_:BasicDialog = null;
         for each(_loc1_ in this.dialogs)
         {
            if(_loc1_.isVisible())
            {
               _loc1_.hide();
            }
         }
      }
      
      public function hideDialog(param1:Class) : void
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ is param1 && _loc2_.isVisible())
            {
               _loc2_.hide();
            }
         }
      }
      
      public function clearDialog(param1:BasicDialog) : void
      {
         var _loc2_:int = this.dialogs.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.dialogs.splice(_loc2_,1);
         }
      }
      
      public function clearAllDialogs() : void
      {
         var _loc1_:BasicDialog = null;
         for each(_loc1_ in this.dialogs)
         {
            _loc1_.hide();
            _loc1_.destroy();
            if(_loc1_.disp && _loc1_.disp.parent == this.dialogLayer)
            {
               this.dialogLayer.removeChild(_loc1_.disp);
            }
            if(_loc1_.disp && _loc1_.disp.parent == this.adminLayer)
            {
               this.adminLayer.removeChild(_loc1_.disp);
            }
         }
         this.dialogs = new Vector.<BasicDialog>();
      }
      
      public function showScreen(param1:String, param2:BasicProperties = null) : BasicScreen
      {
         var _loc3_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc3_ = this.screens[param1] as BasicScreen;
            _loc3_.setProperties(param2);
         }
         else
         {
            _loc3_ = this.createFlashComponent(param1) as BasicScreen;
            this.screens[param1] = _loc3_;
            _loc3_.setProperties(param2);
            this.screenLayer.addChild(_loc3_.disp);
         }
         _loc3_.show();
         return _loc3_;
      }
      
      public function hideScreen(param1:String) : void
      {
         var _loc2_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc2_ = this.screens[param1] as BasicScreen;
            _loc2_.hide();
         }
      }
      
      public function hideAllScreens() : void
      {
         var _loc1_:BasicScreen = null;
         for each(_loc1_ in this.screens)
         {
            if(_loc1_.isVisible())
            {
               _loc1_.hide();
            }
         }
      }
      
      public function onTopScreen(param1:String) : void
      {
         var _loc2_:BasicScreen = null;
         if(this.screens[param1])
         {
            _loc2_ = this.screens[param1] as BasicScreen;
            this.screenLayer.setChildIndex(_loc2_.disp,this.screenLayer.numChildren - 1);
         }
      }
      
      public function createIdleLayer() : void
      {
         this.idleHolderLayer = new Sprite();
         this.idleScreen = new BasicIdleScreen(this.idleHolderLayer);
         layoutManager.addChild(this.idleHolderLayer);
      }
      
      public function clearAllScreens() : void
      {
         var _loc1_:BasicScreen = null;
         for each(_loc1_ in this.screens)
         {
            _loc1_.hide();
            _loc1_.destroy();
            this.screenLayer.removeChild(_loc1_.disp);
         }
         this.screens = new Dictionary();
      }
      
      public function showPanel(param1:String, param2:BasicProperties = null) : void
      {
         var _loc3_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc3_ = this.panels[param1] as BasicPanel;
            _loc3_.setProperties(param2);
         }
         else
         {
            _loc3_ = this.createFlashComponent(param1) as BasicPanel;
            _loc3_.disp.visible = false;
            this.panels[param1] = _loc3_;
            _loc3_.setProperties(param2);
            this.panelLayer.addChild(_loc3_.disp);
         }
         if(!_loc3_.isVisible())
         {
            _loc3_.show();
         }
      }
      
      public function hidePanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            if(_loc2_.isVisible())
            {
               _loc2_.hide();
            }
         }
      }
      
      public function clearAllPanels() : void
      {
         var _loc1_:BasicPanel = null;
         for each(_loc1_ in this.panels)
         {
            _loc1_.hide();
            _loc1_.destroy();
            _loc1_.disp.parent.removeChild(_loc1_.disp);
         }
         this.panels = new Dictionary();
      }
      
      public function hideAllPanels() : void
      {
         var _loc1_:BasicPanel = null;
         for each(_loc1_ in this.panels)
         {
            if(_loc1_.isVisible())
            {
               _loc1_.hide();
            }
         }
      }
      
      public function lockPanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            _loc2_.lockPanel();
         }
      }
      
      public function unLockPanel(param1:String) : void
      {
         var _loc2_:BasicPanel = null;
         if(this.panels[param1])
         {
            _loc2_ = this.panels[param1] as BasicPanel;
            _loc2_.unLockPanel();
         }
      }
      
      public function existsDialog(param1:Class) : Boolean
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isPanelVisible(param1:Class) : Boolean
      {
         var _loc2_:BasicPanel = null;
         for each(_loc2_ in this.panels)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return _loc2_.isVisible();
            }
         }
         return false;
      }
      
      public function isDialogVisible(param1:Class) : Boolean
      {
         var _loc2_:BasicDialog = null;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_ is param1)
            {
               return _loc2_.isVisible();
            }
         }
         return false;
      }
      
      public function get numVisibleDialogs() : int
      {
         var _loc2_:BasicDialog = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.dialogs)
         {
            if(_loc2_ && _loc2_.isVisible())
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function clearAllLayoutContent() : void
      {
         this.clearAllPanels();
         this.clearAllDialogs();
         this.clearAllScreens();
      }
      
      protected function createFlashComponent(param1:String) : FlashUIComponent
      {
         return null;
      }
      
      public function checkWaitingAnimState(param1:String) : void
      {
         var _loc2_:BasicDialog = null;
         var _loc3_:BasicPanel = null;
         var _loc4_:BasicScreen = null;
         for each(_loc2_ in this.dialogs)
         {
            _loc2_.checkWaitingAnimState(param1);
         }
         for each(_loc3_ in this.panels)
         {
            _loc3_.checkWaitingAnimState(param1);
         }
         for each(_loc4_ in this.screens)
         {
            _loc4_.checkWaitingAnimState(param1);
         }
      }
      
      public function toggleFullscreen() : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
         else
         {
            try
            {
               stage.displayState = StageDisplayState.FULL_SCREEN;
               return;
            }
            catch(error:Error)
            {
               showDialog(CommonDialogNames.StandardOkDialog_NAME,new BasicStandardOkDialogProperties(BasicModel.languageData.getTextById("fullscreenerror_msg_title"),BasicModel.languageData.getTextById("fullscreenerror_msg_copy")));
               return;
            }
         }
      }
      
      public function revertFullscreen() : void
      {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      public function showFPS() : void
      {
      }
      
      public function hideFPS() : void
      {
      }
      
      public function isFPSshown() : Boolean
      {
         return false;
      }
      
      public function toggleFPSvisibility() : void
      {
         if(this.isFPSshown())
         {
            this.hideFPS();
         }
         else
         {
            this.showFPS();
         }
      }
      
      public function enableProgressbar() : void
      {
         this._backgroundComponent.progressBarEnabled = true;
      }
      
      public function disableProgressbar() : void
      {
         this._backgroundComponent.progressBarEnabled = false;
      }
      
      public function onEndProgressbar() : void
      {
         this._backgroundComponent.hideProgressBar();
      }
      
      public function onStartProgressbar() : void
      {
         this._backgroundComponent.show();
         this._backgroundComponent.showProgressBar();
      }
      
      public function get inGameState() : Boolean
      {
         return this._currentState >= 10;
      }
      
      public function get outGameState() : Boolean
      {
         return this._currentState < 10;
      }
      
      public function get currentState() : int
      {
         return this._currentState;
      }
      
      public function showBackgroundLayer() : void
      {
         this._backgroundComponent.show();
      }
      
      public function showServerAndClientVersion() : void
      {
         this._backgroundComponent.showVersion();
      }
      
      public function hideBackgroundLayer() : void
      {
         this._backgroundComponent.hide();
      }
      
      public function get scaleFactor() : Number
      {
         return this._backgroundComponent.scaleFactor;
      }
      
      public function get gameNullPoint() : Number
      {
         return (this._backgroundComponent as BasicBackgroundComponent).gameNullPoint;
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
      
      public function get mouseLayer() : Sprite
      {
         return this._mouseLayer;
      }
   }
}
