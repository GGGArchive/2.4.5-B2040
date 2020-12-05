package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.controller.commands.duel.StartDuelFightCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.GetArmamentPresetStatusCommand;
   import com.goodgamestudios.mafia.controller.commands.equipment.ViewArmamentCommand;
   import com.goodgamestudios.mafia.event.model.MafiaDuelEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaArmamentData;
   import com.goodgamestudios.mafia.model.components.user.MafiaPreCombatData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.view.components.MafiaArmamentGrid;
   import com.goodgamestudios.mafia.view.components.MafiaArmamentPresetSelection;
   import com.goodgamestudios.mafia.view.screens.inventory.MafiaInventoryComponent;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaPreCombatScreenProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MafiaPreCombatScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaPreCombatScreen";
      
      protected static var _useConsumables:Boolean = true;
       
      
      private const INVENTORY_POS_COLLAPSED:Number = -1290.75;
      
      private const INVENTORY_POS_EXPANDED:Number = -899.75;
      
      protected var playerArmamentGrid:MafiaArmamentGrid;
      
      protected var playerInventory:MafiaInventoryComponent;
      
      protected var opponentArmamentGrid:MafiaArmamentGrid;
      
      protected var armamentPresetSelection:MafiaArmamentPresetSelection;
      
      public function MafiaPreCombatScreen(param1:DisplayObject)
      {
         super(param1);
         this.playerArmamentGrid = new MafiaArmamentGrid(this.preCombatScreen.fighterLeft.armamentGrid);
         this.playerInventory = new MafiaInventoryComponent(this.preCombatScreen.fighterLeft.inventoryPanel.inventory,6);
         this.opponentArmamentGrid = new MafiaArmamentGrid(this.preCombatScreen.fighterRight.armamentGrid);
         this.armamentPresetSelection = new MafiaArmamentPresetSelection(this.preCombatScreen.fighterLeft.combatPreset);
      }
      
      public static function get useConsumables() : Boolean
      {
         return _useConsumables;
      }
      
      override protected function removeEvents() : void
      {
         super.removeEvents();
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_MULTIFIGHT;
      }
      
      override protected function applyProperties() : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         _useConsumables = true;
         this.updateConsumableCheckbox();
         this.resetInventoryPanel();
         this.preCombatScreen.btn_attack.enableButton = true;
         this.preCombatScreen.btn_attack.update();
         this.fillStaticTexts();
         this.fillPlayerData();
         this.fillOpponentData(this.preCombatData.opponentData,this.preCombatData.opponentArmament);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_DATA,this.onOwnArmamentChanged);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onOppentDataChanged);
         controller.addEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ARMAMENT_DATA,this.onOppentDataChanged);
         controller.addEventListener(MafiaUserEvent.BACK_TO_PRECOMBAT,this.onBackToPrecombat);
         controller.addEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.addEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA,this.onPresetData);
         GetArmamentPresetStatusCommand.sendCommand();
      }
      
      override public function hide() : void
      {
         super.hide();
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_DATA,this.onOwnArmamentChanged);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_AVATAR_DATA,this.onOppentDataChanged);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OTHER_USER_ARMAMENT_DATA,this.onOppentDataChanged);
         controller.removeEventListener(MafiaUserEvent.BACK_TO_PRECOMBAT,this.onBackToPrecombat);
         controller.removeEventListener(MafiaDuelEvent.CHANGE_DUEL_RESULT,this.onChangeDuelResult);
         controller.removeEventListener(MafiaUserEvent.CHANGE_OWN_USER_ARMAMENT_PRESET_DATA,this.onPresetData);
         controller.dispatchEvent(new MafiaDuelEvent(MafiaDuelEvent.CANCELLED_DUEL_PREPARATION));
      }
      
      private function onBackToPrecombat(param1:Event) : void
      {
         this.preCombatScreen.btn_attack.enableButton = true;
      }
      
      protected function onOwnArmamentChanged(param1:Event) : void
      {
         this.playerArmamentGrid.fill(MafiaModel.userData.armament);
      }
      
      protected function onOppentDataChanged(param1:Event) : void
      {
         this.fillOpponentData(this.preCombatData.opponentData,this.preCombatData.opponentArmament);
      }
      
      protected function fillStaticTexts() : void
      {
         this.preCombatScreen.fighterLeft.txt_attack_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
         this.preCombatScreen.fighterLeft.txt_endurance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
         this.preCombatScreen.fighterLeft.txt_luck_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
         this.preCombatScreen.fighterLeft.txt_toughness_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         this.preCombatScreen.fighterRight.txt_attack_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
         this.preCombatScreen.fighterRight.txt_endurance_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
         this.preCombatScreen.fighterRight.txt_luck_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
         this.preCombatScreen.fighterRight.txt_toughness_label.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         this.preCombatScreen.fighterLeft.txt_deactivate_consumables.text = MafiaModel.languageData.getTextById("MafiaPreFightScreen_4");
         this.preCombatScreen.btn_attack.toolTipText = MafiaModel.languageData.getTextById("MafiaPreFightScreen_1");
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_toInventory.toolTipText = MafiaModel.languageData.getTextById("MafiaPreFightScreen_2");
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_inventoryDone.toolTipText = MafiaModel.languageData.getTextById("MafiaPreFightScreen_3");
      }
      
      protected function fillPlayerData() : void
      {
         MovieClipHelper.clearMovieClip(this.preCombatScreen.fighterLeft.avatarHolder);
         MovieClipHelper.clearMovieClip(this.preCombatScreen.fighterLeft.header.classHolder);
         var _loc1_:Sprite = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(MafiaModel.userData.profileData.picString),Constants_ViewScales.SCALE_AVATAR_IN_PRECOMBAT,true,Constants_ViewScales.SCALE_AVATAR_IN_PRECOMBAT);
         this.preCombatScreen.fighterLeft.avatarHolder.addChild(_loc1_);
         var _loc2_:Sprite = AvatarHelper.createClassSymbol(MafiaModel.userData.profileData.characterClass);
         this.preCombatScreen.fighterLeft.header.classHolder.addChild(_loc2_);
         var _loc3_:String = MafiaModel.userData.profileData.name;
         this.preCombatScreen.fighterLeft.header.txt_name.text = _loc3_;
         var _loc4_:String = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + MafiaModel.userData.profileData.level;
         this.preCombatScreen.fighterLeft.header.txt_level.text = _loc4_;
         this.preCombatScreen.fighterLeft.healthBar.line.scaleX = 1;
         this.preCombatScreen.fighterLeft.txt_health.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.health,MafiaModel.languageData.getTextById) + "/" + NumberStringHelper.groupString(MafiaModel.userData.profileData.health,MafiaModel.languageData.getTextById);
         this.preCombatScreen.fighterLeft.txt_attack_value.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.attack,MafiaModel.languageData.getTextById);
         this.preCombatScreen.fighterLeft.txt_endurance_value.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.endurance,MafiaModel.languageData.getTextById);
         this.preCombatScreen.fighterLeft.txt_luck_value.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.luck,MafiaModel.languageData.getTextById);
         this.preCombatScreen.fighterLeft.txt_toughness_value.text = NumberStringHelper.groupString(MafiaModel.userData.profileData.toughness,MafiaModel.languageData.getTextById);
         this.playerArmamentGrid.fill(MafiaModel.userData.armament);
         this.playerInventory.show();
      }
      
      protected function showInventoryPanel() : void
      {
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_toInventory.visible = false;
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_inventoryDone.visible = true;
         new GTween(this.preCombatScreen.fighterLeft.inventoryPanel,0.5,{"x":this.INVENTORY_POS_EXPANDED});
         new GTween(this.preCombatScreen.fighterRight,0.25,{"alpha":0});
      }
      
      protected function hideInventoryPanel() : void
      {
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_toInventory.visible = true;
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_inventoryDone.visible = false;
         new GTween(this.preCombatScreen.fighterLeft.inventoryPanel,0.5,{"x":this.INVENTORY_POS_COLLAPSED});
         new GTween(this.preCombatScreen.fighterRight,0.25,{"alpha":1});
      }
      
      protected function resetInventoryPanel() : void
      {
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_toInventory.visible = true;
         this.preCombatScreen.fighterLeft.inventoryPanel.btn_inventoryDone.visible = false;
         this.preCombatScreen.fighterLeft.inventoryPanel.x = this.INVENTORY_POS_COLLAPSED;
         this.preCombatScreen.fighterRight.alpha = 1;
      }
      
      protected function fillOpponentData(param1:MafiaProfileData, param2:MafiaArmamentData) : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc5_:String = null;
         MovieClipHelper.clearMovieClip(this.preCombatScreen.fighterRight.avatarHolder);
         MovieClipHelper.clearMovieClip(this.preCombatScreen.fighterRight.header.classHolder);
         if(param1 != null)
         {
            _loc3_ = AvatarHelper.createAvatar(AvatarHelper.createAvatarVOFromString(param1.picString),Constants_ViewScales.SCALE_AVATAR_IN_PRECOMBAT,true,Constants_ViewScales.SCALE_AVATAR_IN_PRECOMBAT);
            this.preCombatScreen.fighterRight.avatarHolder.addChild(_loc3_);
            _loc4_ = AvatarHelper.createClassSymbol(param1.characterClass);
            this.preCombatScreen.fighterRight.header.classHolder.addChild(_loc4_);
            this.preCombatScreen.fighterRight.header.txt_name.text = param1.name;
            _loc5_ = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " " + param1.level;
            this.preCombatScreen.fighterRight.header.txt_level.text = _loc5_;
            this.preCombatScreen.fighterRight.txt_health.text = NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById) + "/" + NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById);
            this.preCombatScreen.fighterRight.txt_attack_value.text = NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById);
            this.preCombatScreen.fighterRight.txt_endurance_value.text = NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById);
            this.preCombatScreen.fighterRight.txt_luck_value.text = NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById);
            this.preCombatScreen.fighterRight.txt_toughness_value.text = NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById);
         }
         else
         {
            this.preCombatScreen.fighterRight.header.txt_name.text = "???";
            this.preCombatScreen.fighterRight.header.txt_level.text = MafiaModel.languageData.getTextById("MafiaRankingScreen_text_level") + " ???";
            this.preCombatScreen.fighterRight.txt_health.text = "???/???";
            this.preCombatScreen.fighterRight.txt_attack_value.text = "???";
            this.preCombatScreen.fighterRight.txt_endurance_value.text = "???";
            this.preCombatScreen.fighterRight.txt_luck_value.text = "???";
            this.preCombatScreen.fighterRight.txt_toughness_value.text = "???";
         }
         if(param2 != null)
         {
            this.opponentArmamentGrid.fill(param2);
         }
         else
         {
            this.opponentArmamentGrid.clear();
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.preCombatScreen.btn_attack:
               if(this.preCombatScreen.btn_attack.enabled)
               {
                  this.preCombatScreen.btn_attack.enableButton = false;
                  this.preCombatData.lastUsedConsumables = _useConsumables;
                  StartDuelFightCommand.sendCommand(this.preCombatData.opponentId,_useConsumables,MafiaModel.userData.armament);
               }
               break;
            case this.preCombatScreen.fighterLeft.inventoryPanel.btn_toInventory:
               this.showInventoryPanel();
               break;
            case this.preCombatScreen.fighterLeft.inventoryPanel.btn_inventoryDone:
               this.hideInventoryPanel();
               break;
            case this.preCombatScreen.fighterLeft.checkbox_dont_use_consumables:
               _useConsumables = !_useConsumables;
               this.updateConsumableCheckbox();
         }
      }
      
      private function updateConsumableCheckbox() : void
      {
         if(!_useConsumables)
         {
            this.preCombatScreen.fighterLeft.checkbox_dont_use_consumables.selected();
         }
         else
         {
            this.preCombatScreen.fighterLeft.checkbox_dont_use_consumables.deselected();
         }
         this.playerArmamentGrid.fill(MafiaModel.userData.armament);
      }
      
      private function onChangeDuelResult(param1:MafiaDuelEvent) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_DUEL_FIGHT;
      }
      
      protected function get preCombatData() : MafiaPreCombatData
      {
         return (properties as MafiaPreCombatScreenProperties).preCombatData;
      }
      
      protected function get preCombatScreen() : MafiaPreCombat
      {
         return disp as MafiaPreCombat;
      }
      
      private function onPresetData(param1:Event) : void
      {
         this.armamentPresetSelection.setup(MafiaModel.userData.armamentPresetData.unlockedArmaments,MafiaModel.userData.armamentPresetData.activeArmament,false);
         ViewArmamentCommand.sendCommand(MafiaModel.userData.playerID);
      }
   }
}
