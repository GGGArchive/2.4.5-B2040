package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.event.model.MafiaMissionEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBuyEnergyDialogProperties;
   import com.goodgamestudios.mafia.view.screens.MafiaMissionScreen;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MafiaBuyEnergyDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaBuyEnergyDialog";
       
      
      public function MafiaBuyEnergyDialog(param1:Sprite)
      {
         super(param1);
         this.standardDialog.bg.gotoAndStop(1);
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         super.destroy();
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.pic.gotoAndStop(MafiaModel.userData.profileData.city.index + 1);
         controller.addEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showMissionSelection = true;
         (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).energyBar.fillPreDrinkEnergyBar();
         this.standardDialog.energy.gotoAndStop(2);
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_no;
         this.standardDialog.txt_title.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_title");
         this.standardDialog.btn_buy.enableButton = MafiaModel.userData.userMissionEnergy < 1000 && MafiaModel.userData.missionData.energyRefill < MafiaModel.userData.missionData.maxEnergyRefill;
         this.fillBuyEnergyDialog();
      }
      
      override public function hide() : void
      {
         controller.removeEventListener(MafiaMissionEvent.CHANGE_MISSION_DATA,this.onChangeMissionData);
         if(layoutManager.getScreen(MafiaMissionScreen.NAME))
         {
            (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showMissionSelection = false;
         }
         super.hide();
      }
      
      private function onChangeMissionData(param1:MafiaMissionEvent) : void
      {
         this.standardDialog.btn_buy.enableButton = MafiaModel.userData.userMissionEnergy < 1000 && MafiaModel.userData.missionData.energyRefill < MafiaModel.userData.missionData.maxEnergyRefill;
         this.fillBuyEnergyDialog();
         (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).energyBar.fillPreDrinkEnergyBar();
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         this.fillBuyEnergyDialog();
         this.standardDialog.btn_buy.enableButton = MafiaModel.userData.userMissionEnergy < 1000 && MafiaModel.userData.missionData.energyRefill < MafiaModel.userData.missionData.maxEnergyRefill;
      }
      
      private function fillBuyEnergyDialog() : void
      {
         this.standardDialog.txt_drunken.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_copy_3") + String(" " + MafiaModel.userData.missionData.energyRefill) + "/" + MafiaModel.userData.missionData.maxEnergyRefill.toString();
         this.standardDialog.txt_get.text = "20";
         this.standardDialog.btn_buy.label = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_btn_drink");
         this.standardDialog.btn_buy.goldInfoVisible = true;
         this.standardDialog.btn_buy.goldInfoTimeText = MafiaModel.goldConstants.fillEnergyPrice.toString();
         updateAllTextFields();
         if(MafiaModel.userData.missionData.energyRefill >= MafiaModel.userData.missionData.maxEnergyRefill)
         {
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_copy_5");
         }
         else if(MafiaModel.userData.userMissionEnergy == 1000)
         {
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_copy_1");
         }
         else
         {
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_copy_2");
         }
         if(MafiaModel.userData.missionData.freeEnergyDrinks > 0)
         {
            this.standardDialog.txt_copy.text = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_copy_4");
            this.standardDialog.btn_buy.label = MafiaModel.languageData.getTextById("MafiaBuyEnergyDialog_btn_drink");
            this.standardDialog.btn_buy.goldInfoVisible = false;
         }
         this.standardDialog.btn_buy.update();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
               this.hide();
               (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showMissionSelection = false;
               break;
            case this.standardDialog.btn_buy:
               if(!param1.target.enabled)
               {
                  return;
               }
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes();
               }
               this.standardDialog.btn_buy.enableButton = false;
               break;
            case this.standardDialog.btn_no:
               this.hide();
               (layoutManager.getScreen(MafiaMissionScreen.NAME) as MafiaMissionScreen).showMissionSelection = false;
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : MafiaBuyEnergyDialogProperties
      {
         return properties as MafiaBuyEnergyDialogProperties;
      }
      
      protected function get standardDialog() : MafiaBuyEnergy
      {
         return disp as MafiaBuyEnergy;
      }
   }
}
