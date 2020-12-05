package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class MafiaTutorialController extends BasicTutorialController
   {
      
      public static const TUT_STATE_GO_TO_MISSION:String = "tut_gotomission";
      
      public static const TUT_STATE_BAR_INFO:String = "tut_state_bar_info";
      
      public static const TUT_STATE_SELECTMISSION:String = "tut_selectmission";
      
      public static const TUT_STATE_STARTMISSION:String = "tut_startmission";
      
      public static const TUT_STATE_WAITING_FOR_MISSIONBEGIN:String = "tut_state_waiting_for_missionbegin";
      
      public static const TUT_STATE_ENDMISSION:String = "tut_endmission";
      
      public static const TUT_STATE_MISSION_FIGHT_PROGRESS:String = "tut_state_mission_fight_progress";
      
      public static const TUT_STATE_MISSION_FIGHT:String = "tut_missionfight";
      
      public static const TUT_STATE_LEVEL_UP:String = "tut_state_level_up";
      
      public static const TUT_STATE_GO_TO_INVENTAR:String = "tut_missionfightreward";
      
      public static const TUT_STATE_PROFIL:String = "tut_state_profil";
      
      public static const TUT_STATE_SELECT_WEAPON:String = "tut_state_select_weapon";
      
      public static const TUT_STATE_DRAG_WEAPON:String = "tut_state_drag_weapon";
      
      public static const TUT_STATE_UPGRADE_ATTRIBUTES_1:String = "tut_state_upgrade_attributes_1";
      
      public static const TUT_STATE_UPGRADE_ATTRIBUTES_2:String = "tut_state_upgrade_attributes_2";
      
      public static const TUT_STATE_UPGRADE_ATTRIBUTES_3:String = "tut_state_upgrade_attributes_3";
      
      public static const TUT_STATE_TO_SHOP:String = "tut_state_to_shop";
      
      public static const TUT_STATE_GO_TO_CONSUMABLES:String = "tut_state_go_to_consumables";
      
      public static const TUT_STATE_SELECT_DYNAMITE:String = "tut_state_select_dynamite";
      
      public static const TUT_STATE_DRAG_DYNAMITE:String = "tut_state_drag_dynamite";
      
      public static const TUT_STATE_GO_TO_PROFIL:String = "tut_state_go_to_profil";
      
      public static const TUT_STATE_INVENTORY_SELECT_DYNAMITE:String = "tut_state_inventory_select_dynamite";
      
      public static const TUT_STATE_INVENTORY_DRAG_DYNAMITE:String = "tut_state_inventory_drag_dynamite";
      
      public static const TUT_STATE_SELECT_AMOUNT:String = "tut_state_select_amount";
      
      public static const TUT_STATE_GO_TO_GODFATHER:String = "tut_state_go_to_godfather";
      
      public static const TUT_STATE_TUTREWARD:String = "tut_tutreward";
       
      
      public function MafiaTutorialController()
      {
         super();
         stateOrder = new Array(TUT_STATE_WELCOME,TUT_STATE_GO_TO_MISSION,TUT_STATE_BAR_INFO,TUT_STATE_SELECTMISSION,TUT_STATE_STARTMISSION,TUT_STATE_WAITING_FOR_MISSIONBEGIN,TUT_STATE_ENDMISSION,TUT_STATE_MISSION_FIGHT_PROGRESS,TUT_STATE_MISSION_FIGHT,TUT_STATE_LEVEL_UP,TUT_STATE_GO_TO_INVENTAR,TUT_STATE_PROFIL,TUT_STATE_SELECT_WEAPON,TUT_STATE_DRAG_WEAPON,TUT_STATE_UPGRADE_ATTRIBUTES_1,TUT_STATE_UPGRADE_ATTRIBUTES_2,TUT_STATE_UPGRADE_ATTRIBUTES_3,TUT_STATE_TO_SHOP,TUT_STATE_GO_TO_CONSUMABLES,TUT_STATE_SELECT_DYNAMITE,TUT_STATE_DRAG_DYNAMITE,TUT_STATE_GO_TO_PROFIL,TUT_STATE_INVENTORY_SELECT_DYNAMITE,TUT_STATE_INVENTORY_DRAG_DYNAMITE,TUT_STATE_SELECT_AMOUNT,TUT_STATE_GO_TO_GODFATHER,TUT_STATE_TUTREWARD,TUT_STATE_COMPLETED);
      }
      
      public static function getInstance() : MafiaTutorialController
      {
         if(!tutorialController)
         {
            tutorialController = new MafiaTutorialController();
         }
         return tutorialController as MafiaTutorialController;
      }
      
      override public function startTutorial(param1:MovieClip) : void
      {
         this.layoutManager.addTutorialPanel();
         param1.mouseChildren = false;
         param1.mouseEnabled = false;
         super.startTutorial(param1);
      }
      
      public function addTutorialArrow(param1:DisplayObjectContainer, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc4_:MovieClip = new TutorialArrow();
         param1.addChild(_loc4_);
         param1.mouseChildren = false;
         param1.mouseEnabled = false;
         if(param2)
         {
            _loc4_.scaleX = -1;
         }
         if(param3)
         {
            _loc4_.scaleY = -1;
         }
      }
      
      override public function endTutorial() : void
      {
         super.endTutorial();
         this.layoutManager.removeTutorialPanel();
         this.layoutManager.state = Constants_LayoutStates.STATE_MISSION;
         MafiaDialogHandler.getInstance().blockDialogs = false;
      }
      
      override public function reset() : void
      {
         if(isActive)
         {
            removeArrow();
            this.endTutorial();
         }
      }
      
      override public function set tutorialState(param1:String) : void
      {
         trace("TUTORIALSTATE: " + param1);
         if(param1 == TUT_STATE_COMPLETED)
         {
            this.endTutorial();
         }
         _tutorialState = param1;
         trace("CURRENT_STEP_STATE: " + _currentStateStep);
         BasicController.getInstance().dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE));
      }
      
      override public function resetCurrentStep() : void
      {
         BasicController.getInstance().dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_RESET_CURRENT_STEP));
      }
      
      public function previousStep() : void
      {
         _currentStateStep--;
         this.tutorialState = stateOrder[_currentStateStep];
      }
      
      public function setStep(param1:String) : void
      {
         removeArrow();
         _currentStateStep = stateOrder.indexOf(param1);
         _tutorialState = param1;
         trace("CURRENT_STEP_STATE: " + _currentStateStep);
         BasicController.getInstance().dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_STATE_CHANGE));
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
