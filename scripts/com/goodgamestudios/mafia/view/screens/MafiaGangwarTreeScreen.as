package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.controller.commands.gangwars.StartGangwarFightCommand;
   import com.goodgamestudios.mafia.controller.commands.specialevent.city.StartCityEventFightCommand;
   import com.goodgamestudios.mafia.event.model.MafiaGangwarEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaFullInventoryDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaFullInventoryDialogProperties;
   import com.goodgamestudios.mafia.view.screens.properties.MafiaGangwarTreeScreenProperties;
   import com.goodgamestudios.mafia.vo.gangwar.GangwarOpponentVO;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   public class MafiaGangwarTreeScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaGangwarTreeScreen";
       
      
      private var progress:int;
      
      private var _tree:MovieClip;
      
      private const MAX_SICILIAN_BEAST_OPPONENTS:int = 5;
      
      public function MafiaGangwarTreeScreen(param1:DisplayObject)
      {
         super(param1,false);
      }
      
      override public function show() : void
      {
         super.show();
         controller.addEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_OPPONENT_DATA,this.onDungeonOpponentData);
         controller.addEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_RESULT,this.onDungeonFightResult);
         controller.addEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_TIMER,this.onDungeonTimer);
         controller.addEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
      }
      
      override protected function onChangeUserData(param1:MafiaUserEvent) : void
      {
         var _loc2_:MovieClip = MafiaGangwarTree["o" + this.gangwarTreeData.dungeon.playerProgress];
         if(_loc2_)
         {
            _loc2_.btn_attack.enableButton = true;
         }
      }
      
      override protected function removeEvents() : void
      {
         controller.removeEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_TIMER,this.onDungeonTimer);
         controller.removeEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_OPPONENT_DATA,this.onDungeonOpponentData);
         controller.removeEventListener(MafiaGangwarEvent.CHANGE_GANGWAR_RESULT,this.onDungeonFightResult);
         controller.removeEventListener(MafiaSpecialEventsEvent.SICILIAN_TIME_UPDATE,this.onSicilianTimer);
         super.removeEvents();
      }
      
      private function onSicilianTimer(param1:MafiaSpecialEventsEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:String = null;
         this.progress = MafiaModel.specialEvent.sicilianEvent.gangwarProgress;
         if(this.progress < this.MAX_SICILIAN_BEAST_OPPONENTS && this.progress >= 0)
         {
            if(!this._tree)
            {
               this._tree = new Tree_4_1();
            }
            _loc2_ = this._tree["o" + this.progress] as MovieClip;
            if(MafiaModel.specialEvent.sicilianEvent.fightCooldown > 0)
            {
               _loc3_ = MafiaModel.specialEvent.sicilianEvent.fightCooldownTimeString;
               if(!_loc2_)
               {
                  return;
               }
               _loc2_.btn_attack.goldInfoVisible = true;
               _loc2_.btn_attack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + _loc3_;
               _loc2_.btn_attack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeDungeonTimePricePerSecond.toString();
               updateAllTextFields();
            }
            else
            {
               _loc2_.btn_attack.goldInfoVisible = false;
            }
         }
         else
         {
            trace("Progress value inaccurate");
         }
      }
      
      private function fillTree(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         MovieClipHelper.clearMovieClip(this.mafiaGangwarTree.treeholder);
         var _loc2_:City = MafiaModel.userData.gangwarData.city;
         if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            _loc2_ = City.Sicily;
         }
         switch(_loc2_)
         {
            case City.NewYork:
            case City.Miami:
               switch(this.gangwarTreeData.dungeon.district_id % 2)
               {
                  case 0:
                     this._tree = new Tree_0_1();
                     break;
                  case 1:
                     this._tree = new Tree_0_2();
               }
               break;
            case City.Hongkong:
               this._tree = new Tree_0_3();
               break;
            case City.Sicily:
               this._tree = new Tree_4_1();
         }
         this.mafiaGangwarTree.treeholder.addChild(this._tree);
         if(MafiaModel.userData.gangwarData.city == City.Sicily)
         {
            this._tree.txt_family.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_1",[MafiaModel.languageData.getTextById("event_sicilianbeast_dungeon_family")]);
         }
         else
         {
            this._tree.txt_family.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_1",[" " + MafiaModel.languageData.getTextById("MafiaGangwarfare_" + MafiaModel.userData.profileData.city.index + "_Family_" + int(this.gangwarTreeData.dungeon.district_id + 1).toString())]);
         }
         this.mafiaGangwarTree.btn_back.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         this.mafiaGangwarTree.backLayer.width = this.mafiaGangwarTree.btn_back.width + 10;
         var _loc3_:uint = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = this._tree["o" + String(_loc3_)] as MovieClip;
            MovieClipHelper.clearMovieClip(_loc4_.mc_holder);
            _loc4_.btn_attack.visible = false;
            _loc4_.properties = null;
            _loc3_++;
         }
      }
      
      private function onDungeonOpponentData(param1:MafiaGangwarEvent) : void
      {
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:ColorMatrix = null;
         var _loc7_:MovieClip = null;
         var _loc2_:Vector.<GangwarOpponentVO> = param1.params[0] as Vector.<GangwarOpponentVO>;
         this.progress = param1.params[1];
         this.fillTree(_loc2_.length);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = this._tree["o" + _loc3_] as MovieClip;
            _loc4_.mask = null;
            _loc5_ = this._tree["m" + _loc3_] as MovieClip;
            _loc5_.visible = false;
            if(_loc3_ < 8)
            {
               _loc7_ = this._tree["arrow" + _loc3_] as MovieClip;
            }
            if(_loc7_)
            {
               _loc7_.visible = false;
            }
            _loc4_.btn_attack.visible = false;
            MovieClipHelper.clearMovieClip(_loc4_.mc_holder);
            _loc4_.strips.visible = false;
            _loc4_.mc_holder.addChild(_loc2_[_loc3_].picMC);
            _loc4_.properties = _loc2_[_loc3_];
            _loc6_ = new ColorMatrix();
            _loc6_.reset();
            _loc4_.mc_holder.filters = [_loc6_.filter];
            TextFieldHelper.changeTextFromatSizeByTextWidth(14,_loc4_.level.txt_level,_loc2_[_loc3_].opponentLevel.toString());
            _loc4_.level.filters = [_loc6_.filter];
            _loc4_.shot.visible = false;
            if(this.progress < _loc3_)
            {
               _loc6_.adjustSaturation(0.1);
               _loc4_.mc_holder.filters = [_loc6_.filter];
               _loc4_.level.filters = [_loc6_.filter];
               _loc4_.bg.gotoAndStop(3);
               if(_loc7_)
               {
                  _loc7_.visible = true;
               }
            }
            if(this.progress > _loc3_)
            {
               _loc6_.adjustSaturation(0.1);
               _loc6_.adjustBrightness(-70,-70,-70);
               _loc4_.mc_holder.filters = [_loc6_.filter];
               _loc4_.level.filters = [_loc6_.filter];
               _loc4_.shot.visible = true;
               _loc5_.visible = true;
               _loc5_.x = _loc4_.x;
               _loc5_.y = _loc4_.y;
               _loc5_.scaleX = _loc5_.scaleY = _loc4_.scaleX;
               _loc4_.mask = _loc5_;
               _loc4_.strips.visible = true;
               _loc4_.bg.gotoAndStop(2);
            }
            if(this.progress == _loc3_)
            {
               _loc4_.btn_attack.label = MafiaModel.languageData.getTextById("MafiaDuelScreen_btn_attack");
               _loc4_.btn_attack.visible = true;
               _loc4_.btn_attack.goldInfoVisible = false;
               _loc4_.bg.gotoAndStop(1);
               if(_loc7_)
               {
                  _loc7_.visible = true;
               }
            }
            _loc4_.filters = [new DropShadowFilter(3,45,0,0.3,3,3)];
            _loc3_++;
         }
      }
      
      private function onDungeonFightResult(param1:MafiaGangwarEvent) : void
      {
         var _loc2_:MovieClip = this._tree["o" + this.progress.toString()] as MovieClip;
         _loc2_.btn_attack.enableButton = true;
         layoutManager.state = Constants_LayoutStates.STATE_GANGWAR_FIGHT;
      }
      
      private function onDungeonTimer(param1:MafiaGangwarEvent) : void
      {
         this.progress = param1.params[1];
         var _loc2_:MovieClip = this._tree["o" + this.progress.toString()] as MovieClip;
         if(!_loc2_)
         {
            return;
         }
         _loc2_.btn_attack.goldInfoVisible = true;
         _loc2_.btn_attack.goldInfoTimeText = MafiaModel.languageData.getTextById("tt_MafiaButton_forfree") + " " + param1.params[0];
         _loc2_.btn_attack.goldInfoGoldText = MafiaModel.goldConstants.cutNextFreeDungeonTimePricePerSecond.toString();
         updateAllTextFields();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target is TextField)
         {
            return;
         }
         if(param1.target is Btn_AttackVersionTwo)
         {
            if(!(param1.target as Btn_AttackVersionTwo).enabled)
            {
               return;
            }
            if(!MafiaModel.userData.inventory.isInventoryFull)
            {
               this.onStartDungeonFight();
            }
            else
            {
               layoutManager.showDialog(MafiaFullInventoryDialog.NAME,new MafiaFullInventoryDialogProperties(0,MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_title"),MafiaModel.languageData.getTextById("MafiaInventoryFullDialog_copy_1"),this.onStartDungeonFight,this.gotoShop));
            }
         }
         switch(param1.target)
         {
            case this.mafiaGangwarTree.btn_back:
               MovieClipHelper.clearMovieClip(this.mafiaGangwarTree.treeholder);
               layoutManager.state = Constants_LayoutStates.STATE_GANGWARS;
         }
         super.onClick(param1);
      }
      
      private function onStartDungeonFight(param1:int = 0) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = true;
         var _loc2_:MovieClip = this._tree["o" + this.gangwarTreeData.dungeon.playerProgress];
         _loc2_.btn_attack.enableButton = false;
         if(MafiaModel.specialEvent.sicilianEvent.isSicilyAndFightOnMap)
         {
            StartCityEventFightCommand.sendCommand();
         }
         else
         {
            StartGangwarFightCommand.sendCommand(this.gangwarTreeData.dungeon.district_id);
         }
      }
      
      private function gotoShop(param1:Object = null) : void
      {
         layoutManager.state = Constants_LayoutStates.STATE_SHOP;
      }
      
      protected function get gangwarTreeData() : MafiaGangwarTreeScreenProperties
      {
         return properties as MafiaGangwarTreeScreenProperties;
      }
      
      public function get mafiaGangwarTree() : MafiaGangwarTree
      {
         return disp as MafiaGangwarTree;
      }
   }
}
