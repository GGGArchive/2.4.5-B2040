package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.controller.BasicTutorialController;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaSoundController;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.event.MafiaTutorialEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class MafiaTutorialPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaTutorialPanel";
      
      private static const ALIGN_CENTER:int = 0;
      
      private static const ALIGN_TOPRIGHT:int = 1;
      
      private static const OFFSET_SPEECH_HEIGHT:int = 130;
      
      private static const OFFSET_SPEECH_Y:int = 30;
      
      private static const OFFSET_SPEECHTEXT_HEIGHT:int = 100;
      
      private static const OFFSET_SPEECHTEXT_Y:int = 140;
       
      
      private var _alignment:int = 0;
      
      public function MafiaTutorialPanel(param1:DisplayObject)
      {
         super(param1);
         index = PANEL_INDEX_TUTORIAL;
      }
      
      override protected function init() : void
      {
         this.tutorialPanel.gotoAndStop(1);
         this.tutorialPanel.bubble.btn_ok.visible = true;
         this.tutorialPanel.bubble.btn_yes.visible = true;
         this.tutorialPanel.bubble.txt_tutorial.text = "";
         this.tutorialPanel.bubble.tut_reward.visible = false;
         super.updateAllTextFields();
         this.tutorialPanel.bubble.btn_ok.update();
         this.tutorialPanel.bubble.btn_yes.update();
      }
      
      private function get tutorialPanel() : TutorialPanel
      {
         return disp as TutorialPanel;
      }
      
      override protected function onTutorialEvent(param1:MafiaTutorialEvent) : void
      {
         var _loc2_:Boolean = BasicLanguageFontManager.getInstance().useDefaultFont;
         switch(MafiaTutorialController.getInstance().tutorialState)
         {
            case BasicTutorialController.TUT_STATE_WELCOME:
               this.tutorialPanel.gotoAndStop(1);
               this.tutorialPanel.bubble.tut_reward.visible = false;
               this.tutorialPanel.bubble.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_no");
               this.tutorialPanel.bubble.btn_yes.label = MafiaModel.languageData.getTextById("generic_btn_yes");
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_0");
               TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               updateAllTextFields();
               this.tutorialPanel.bubble.btn_ok.update();
               this.tutorialPanel.bubble.btn_yes.update();
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_MISSION:
               this.tutorialPanel.gotoAndStop(2);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("MafiaTutorialStep1Dialog_copy");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_BAR_INFO:
               this.tutorialPanel.gotoAndStop(4);
               this.tutorialPanel.bubble.btn_next.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_2");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               updateAllTextFields();
               this.tutorialPanel.bubble.btn_next.update();
               break;
            case MafiaTutorialController.TUT_STATE_SELECTMISSION:
               this.tutorialPanel.gotoAndStop(5);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_3");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_STARTMISSION:
               this.tutorialPanel.gotoAndStop(6);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_4");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_WAITING_FOR_MISSIONBEGIN:
               this.tutorialPanel.gotoAndStop(7);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_5");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_ENDMISSION:
               this.tutorialPanel.gotoAndStop(8);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_6");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_MISSION_FIGHT_PROGRESS:
               this.tutorialPanel.visible = false;
               break;
            case MafiaTutorialController.TUT_STATE_MISSION_FIGHT:
               this.tutorialPanel.visible = true;
               this.tutorialPanel.gotoAndStop(9);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_7");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_LEVEL_UP:
               this.tutorialPanel.visible = false;
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_INVENTAR:
               this.tutorialPanel.visible = true;
               this.tutorialPanel.gotoAndStop(10);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_8");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_PROFIL:
               MafiaDialogHandler.getInstance().blockDialogs = false;
               this.tutorialPanel.gotoAndStop(11);
               this.tutorialPanel.bubble.btn_next.visible = true;
               this.tutorialPanel.bubble.btn_next.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_9");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               updateAllTextFields();
               this.tutorialPanel.bubble.btn_next.update();
               break;
            case MafiaTutorialController.TUT_STATE_SELECT_WEAPON:
               MafiaDialogHandler.getInstance().blockDialogs = true;
               this.tutorialPanel.gotoAndStop(12);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_10");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_DRAG_WEAPON:
               this.tutorialPanel.gotoAndStop(12);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_10");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_1:
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_2:
            case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_3:
               this.tutorialPanel.gotoAndStop(13);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_11");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_TO_SHOP:
               this.tutorialPanel.gotoAndStop(14);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_12");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_CONSUMABLES:
               this.tutorialPanel.gotoAndStop(15);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_13");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_SELECT_DYNAMITE:
               this.tutorialPanel.gotoAndStop(16);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_14");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_DRAG_DYNAMITE:
               MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_14");
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_PROFIL:
               this.tutorialPanel.gotoAndStop(17);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_15");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_INVENTORY_SELECT_DYNAMITE:
               this.tutorialPanel.gotoAndStop(18);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_16");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_INVENTORY_DRAG_DYNAMITE:
               this.tutorialPanel.gotoAndStop(18);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_16");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_SELECT_AMOUNT:
               this.tutorialPanel.visible = false;
               break;
            case MafiaTutorialController.TUT_STATE_GO_TO_GODFATHER:
               this.tutorialPanel.visible = true;
               this.tutorialPanel.gotoAndStop(19);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_17");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               break;
            case MafiaTutorialController.TUT_STATE_TUTREWARD:
               this.tutorialPanel.gotoAndStop(20);
               this.tutorialPanel.visible = true;
               this.tutorialPanel.mouseChildren = true;
               this.tutorialPanel.mouseEnabled = true;
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("MafiaTutorialStep10Dialog_copy");
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("Mafia_Tutorial_copy_18");
               this.tutorialPanel.bubble.btn_ok.visible = true;
               this.tutorialPanel.bubble.btn_yes.visible = false;
               this.tutorialPanel.bubble.tut_reward.visible = true;
               updateTextField(this.tutorialPanel.bubble.btn_ok.txt_label);
               this.tutorialPanel.bubble.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               this.tutorialPanel.bubble.tut_reward.txt_tutorial1.text = "+" + MafiaModel.goldConstants.tutorialReward.toString();
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               controller.soundController.playSoundEffect(MafiaSoundController.SND_LEVEL_UP);
               updateAllTextFields();
               this.tutorialPanel.bubble.btn_ok.update();
               break;
            case BasicTutorialController.TUT_STATE_CANCEL:
               this.tutorialPanel.mouseChildren = true;
               this.tutorialPanel.mouseEnabled = true;
               this.tutorialPanel.bubble.btn_ok.visible = true;
               this.tutorialPanel.bubble.btn_yes.visible = false;
               this.tutorialPanel.bubble.tut_reward.visible = false;
               updateTextField(this.tutorialPanel.bubble.txt_tutorial);
               this.tutorialPanel.bubble.txt_tutorial.text = MafiaModel.languageData.getTextById("MafiaTutorialStep10Dialog_copy");
               if(_loc2_)
               {
                  TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.tutorialPanel.bubble.txt_tutorial);
               }
               this.tutorialPanel.bubble.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
               updateAllTextFields();
               this.tutorialPanel.bubble.btn_ok.update();
         }
         super.updateAllTextFields();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.tutorialPanel.bubble.btn_ok:
               switch(this.tutController.tutorialState)
               {
                  case BasicTutorialController.TUT_STATE_WELCOME:
                     this.tutController.cancelTutorial();
                     break;
                  case BasicTutorialController.TUT_STATE_CANCEL:
                     MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_QUIT_TUTORIAL,[]);
                     this.tutController.endTutorial();
                     controller.dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_STATE_UNLOCKALL));
                     break;
                  case MafiaTutorialController.TUT_STATE_TUTREWARD:
                     MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_QUIT_TUTORIAL,[]);
                     controller.dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_STATE_UNLOCKALL));
                     this.tutController.nextStep();
                     layoutManager.removeTutorialPanel();
                     break;
                  default:
                     controller.dispatchEvent(new MafiaTutorialEvent(MafiaTutorialEvent.TUTORIAL_STATE_UNLOCKALL));
                     layoutManager.removeTutorialPanel();
               }
               break;
            case this.tutorialPanel.bubble.btn_yes:
               this.tutController.nextStep();
               break;
            case this.tutorialPanel.bubble.btn_next:
               this.tutController.nextStep();
         }
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Rectangle = null;
         super.updatePosition();
         if(disp && disp.stage)
         {
            _loc1_ = disp.getBounds(null);
            switch(this._alignment)
            {
               case ALIGN_CENTER:
               case ALIGN_TOPRIGHT:
                  disp.y = 255 * disp.scaleX;
            }
            disp.x = disp.stage.stageWidth * 0.5;
         }
      }
      
      private function get tutController() : MafiaTutorialController
      {
         return MafiaTutorialController.getInstance();
      }
   }
}
