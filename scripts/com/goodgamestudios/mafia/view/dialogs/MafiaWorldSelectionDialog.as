package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.model.vo.InstanceVO;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.commanding.CommandController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.MafiaComboboxComponent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaWorldSelectionDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaWorldSelection";
       
      
      private var worldSelection:MafiaComboboxComponent;
      
      public function MafiaWorldSelectionDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         MafiaModel.smartfoxClient.userForcedDisconnect = false;
         this.worldSelection = new MafiaComboboxComponent(this.dialog.worldcombobox);
      }
      
      override public function updatePosition() : void
      {
         if(disp && disp.stage)
         {
            super.updatePosition();
            disp.x = layoutManager.gameNullPoint + -dispBounds.left - dispBounds.width * 0.5 + Constants_Basic.GAME_WIDTH * disp.scaleX * 0.5;
            disp.y = -dispBounds.top - dispBounds.height * 0.5 + disp.stage.stageHeight * 0.5 + 150 * disp.scaleY;
         }
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         super.onFontsLoaded(param1);
         this.fillDialog();
      }
      
      override protected function applyProperties() : void
      {
         super.applyProperties();
      }
      
      private function fillDialog() : void
      {
         var _loc3_:InstanceVO = null;
         var _loc4_:Object = null;
         this.dialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_connect");
         this.dialog.txt_title.text = MafiaModel.languageData.getTextById("generic_select_world");
         this.dialog.btn_live.label = "Connect with live settings";
         this.dialog.btn_live.visible = env.isLocal || env.isTest || env.isDevTest;
         this.worldSelection.clearItems();
         var _loc1_:Vector.<InstanceVO> = BasicModel.instanceProxy.getInstancesForActualCountry();
         _loc1_ = _loc1_.reverse();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as InstanceVO;
            _loc4_ = {
               "label":_loc3_.serverName,
               "data":_loc3_
            };
            this.worldSelection.addItem(_loc4_);
            _loc2_++;
         }
         this.preSelectInstance(BasicModel.localData.readInstanceId());
      }
      
      private function preSelectInstance(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.worldSelection.itemData.length)
         {
            if((this.worldSelection.itemData[_loc2_].data as InstanceVO).instanceId == param1)
            {
               this.worldSelection.selectItemIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
         this.worldSelection.selectItemIndex(1);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.dialog.btn_ok:
               this.selectWorld();
               hide();
               break;
            case this.dialog.btn_live:
               env.isLocal = false;
               env.isTest = false;
               env.isDevTest = false;
               this.selectWorld();
               hide();
         }
      }
      
      private function selectWorld() : void
      {
         var _loc1_:InstanceVO = this.worldSelection.selectedData as InstanceVO;
         CommandController.instance.executeCommand(BasicController.COMMAND_CONNECT_TO_INSTANCEVO,_loc1_);
      }
      
      override public function show() : void
      {
         super.show();
         if(BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            this.fillDialog();
         }
      }
      
      private function get dialog() : MafiaWorldSelection
      {
         return disp as MafiaWorldSelection;
      }
   }
}
