package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicToolTipManager;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import com.goodgamestudios.basic.view.tooltips.BasicAdvancedToolTip;
   import com.goodgamestudios.basic.vo.BasicTooltipVO;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAchievementAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaActionPanelAvatarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAdvancedFightEquipmentTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaArrowMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAvatarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaBarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaBoosterAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityDistrictTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityQuestAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaCityQuestBonusTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanBoosterAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanExperienceAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaClanRankingWarStatusAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaDungeonAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaFoodAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaGangMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaGoldAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaItemAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMissionAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaPushAttributAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaQuestlogAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaRoundOfSixteenAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSelfUpdatingTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSicilianDungeonAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSicilianMissionAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaSlotMachineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaUserClanMemberAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaWorkAdvancedTooltip;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.utils.Dictionary;
   
   public class MafiaToolTipManager extends BasicToolTipManager
   {
      
      public static const LEFTDISPMOUSEPOS:String = "left";
      
      public static const RIGHTDISPMOUSEPOS:String = "right";
      
      public static const TOPDISPMOUSEPOS:String = "top";
      
      public static const CENTERDISPSTATICPOS:String = "center";
      
      public static const OVERDISPSTATICPOS:String = "over";
      
      public static const TOOLTIP_LABEL:String = "toolTipText";
      
      public static const TOOLTIP_VO:String = "toolTipVO";
       
      
      private var advancedTooltip:BasicAdvancedToolTip;
      
      public var dispPos:String;
      
      protected var tooltips:Dictionary;
      
      private const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(3,45,0,0.5,5,5);
      
      private const GLOW:GlowFilter = new GlowFilter(0,0.5,2,2,1,1);
      
      protected var currentTarget:DisplayObject;
      
      protected var currentText:Object;
      
      public function MafiaToolTipManager(param1:Sprite)
      {
         super(param1,Tooltip_Body,Tooltip_Arrow);
         super.textFieldHeightAdditive = -5;
         super.backGroundHeightAdditive = 10;
         ARROW_HEIGHT = 13;
         this.tooltips = new Dictionary();
      }
      
      override public function show(param1:Object, param2:DisplayObject = null) : void
      {
         if(param1 == null)
         {
            this.hide();
            return;
         }
         super.show(param1,param2);
         _tooltipLayer.cacheAsBitmap = true;
         _tooltipLayer.filters = [];
         _tooltipLayer.filters = [this.GLOW,this.DROP_SHADOW];
         this.currentTarget = param2;
         this.currentText = param1;
         _tooltipLayer.addEventListener(Event.ENTER_FRAME,this.updateText);
      }
      
      override public function hide() : void
      {
         super.hide();
         this.currentTarget = null;
         this.currentText = null;
         _tooltipLayer.removeEventListener(Event.ENTER_FRAME,this.updateText);
      }
      
      private function updateText(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:DisplayObject = null;
         if(this.currentTarget != null && this.currentTarget.hasOwnProperty("toolTipText"))
         {
            _loc2_ = (this.currentTarget as MovieClip).toolTipText;
            _loc3_ = this.currentTarget;
            if(_loc2_ != this.currentText)
            {
               this.hide();
               this.show(_loc2_,_loc3_);
            }
         }
         else
         {
            this.hide();
         }
      }
      
      override protected function updateTextField() : void
      {
         super.updateTextField();
      }
      
      public function showAdvancedTooltip(param1:BasicTooltipVO, param2:DisplayObject = null) : void
      {
         this.updateTextField();
         if(!param1)
         {
            return;
         }
         if(this.tooltips[param1.advancedTooltipID])
         {
            this.advancedTooltip = this.tooltips[param1.advancedTooltipID] as BasicAdvancedToolTip;
            this.advancedTooltip.setProperties(param1.advancedTooltipProperties);
         }
         else
         {
            this.advancedTooltip = this.createFlashComponent(param1.advancedTooltipID) as BasicAdvancedToolTip;
            this.advancedTooltip.disp.cacheAsBitmap = true;
            this.advancedTooltip.disp.filters = [];
            this.advancedTooltip.disp.filters = [this.GLOW,this.DROP_SHADOW];
            this.tooltips[param1.advancedTooltipID] = this.advancedTooltip;
            this.advancedTooltip.setProperties(param1.advancedTooltipProperties);
            _tooltipLayer.addChild(this.advancedTooltip.disp);
         }
         this.advancedTooltip.disp.alpha = 0;
         this.dispPos = param1.dispPos;
         this.advancedTooltip.show();
         if(!param1.staticPosition)
         {
            this.advancedTooltip.disp.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         else
         {
            this.advancedTooltip.disp.x = MafiaLayoutManager.getInstance().gameNullPoint + param1.staticPosition.x * MafiaLayoutManager.getInstance().scaleFactor;
            this.advancedTooltip.disp.y = param1.staticPosition.y * MafiaLayoutManager.getInstance().scaleFactor;
            if(this.dispPos == CENTERDISPSTATICPOS)
            {
               this.advancedTooltip.disp.y = this.advancedTooltip.disp.y - this.advancedTooltip.disp.height * 0.5;
            }
            if(this.dispPos == OVERDISPSTATICPOS)
            {
               this.advancedTooltip.disp.y = this.advancedTooltip.disp.y - this.advancedTooltip.disp.height;
            }
         }
         new GTween(this.advancedTooltip.disp,0.2,{"alpha":1});
         MafiaLayoutManager.getInstance().customCursor.setCursorType(param1.cursorStyle);
         if(!param2)
         {
            return;
         }
         if(param1.cursorStyle == BasicCustomCursor.CURSOR_ARROW)
         {
            (param2 as MovieClip).buttonMode = false;
            (param2 as MovieClip).useHandCursor = false;
         }
         else
         {
            (param2 as MovieClip).buttonMode = true;
            (param2 as MovieClip).useHandCursor = true;
         }
         _target = param2;
         _target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      override public function hideAdvancedTooltip() : void
      {
         var _loc1_:BasicAdvancedToolTip = null;
         for each(_loc1_ in this.tooltips)
         {
            if(_loc1_.isVisible())
            {
               _loc1_.disp.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               _loc1_.destroy();
               _loc1_.hide();
            }
         }
         if(_target)
         {
            _target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         this.hideAdvancedTooltip();
         this.hide();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.advancedTooltip && this.advancedTooltip.disp.visible)
         {
            if(this.dispPos == TOPDISPMOUSEPOS)
            {
               this.advancedTooltip.disp.y = _tooltipLayer.mouseY - this.advancedTooltip.disp.height - 20;
               this.advancedTooltip.disp.x = _tooltipLayer.mouseX;
               return;
            }
            if(_tooltipLayer.mouseX + this.advancedTooltip.disp.width + 30 > MafiaLayoutManager.getInstance().gameNullPoint + Constants_Basic.GAME_WIDTH * MafiaLayoutManager.getInstance().scaleFactor)
            {
               this.advancedTooltip.disp.x = _tooltipLayer.mouseX - this.advancedTooltip.disp.width * 0.5 - 20;
            }
            else if(this.dispPos == RIGHTDISPMOUSEPOS)
            {
               this.advancedTooltip.disp.x = _tooltipLayer.mouseX + this.advancedTooltip.disp.width * 0.5 + 30;
            }
            else
            {
               this.advancedTooltip.disp.x = _tooltipLayer.mouseX + this.advancedTooltip.disp.width * 0.5 + 30;
            }
            if(_tooltipLayer.mouseY - this.advancedTooltip.disp.height * 0.5 <= 200 * MafiaLayoutManager.getInstance().scaleFactor)
            {
               if(this.advancedTooltip.disp.height > 250)
               {
                  this.advancedTooltip.disp.y = _tooltipLayer.mouseY - this.advancedTooltip.disp.height;
               }
               else
               {
                  this.advancedTooltip.disp.y = _tooltipLayer.mouseY + this.advancedTooltip.disp.height / 4;
               }
            }
            else
            {
               this.advancedTooltip.disp.y = _tooltipLayer.mouseY - this.advancedTooltip.disp.height;
            }
         }
      }
      
      private function createFlashComponent(param1:String) : FlashUIComponent
      {
         switch(param1)
         {
            case MafiaMissionAdvancedTooltip.NAME:
               return new MafiaMissionAdvancedTooltip(new MafiaMissionTooltip());
            case MafiaBarAdvancedTooltip.NAME:
               return new MafiaBarAdvancedTooltip(new MafiaBarTooltip());
            case MafiaBoosterAdvancedTooltip.NAME:
               return new MafiaBoosterAdvancedTooltip(new MafiaBoosterTooltip());
            case MafiaAchievementAdvancedTooltip.NAME:
               return new MafiaAchievementAdvancedTooltip(new MafiaAchievementTooltip());
            case MafiaAvatarAdvancedTooltip.NAME:
               return new MafiaAvatarAdvancedTooltip(new MafiaExperienceTooltip());
            case MafiaFoodAdvancedTooltip.NAME:
               return new MafiaFoodAdvancedTooltip(new MafiaFoodTooltip());
            case MafiaItemAdvancedTooltip.NAME:
               return new MafiaItemAdvancedTooltip(new MafiaItemTooltip());
            case MafiaMultiLineAdvancedTooltip.NAME:
               return new MafiaMultiLineAdvancedTooltip(new MafiaMultiLineTooltip());
            case MafiaArrowMultiLineAdvancedTooltip.NAME:
               return new MafiaArrowMultiLineAdvancedTooltip(new MafiaArrowMultiLineTooltip());
            case MafiaClanExperienceAdvancedTooltip.NAME:
               return new MafiaClanExperienceAdvancedTooltip(new MafiaExperienceTooltip());
            case MafiaDungeonAdvancedTooltip.NAME:
               return new MafiaDungeonAdvancedTooltip(new MafiaGangwarTooltip());
            case MafiaUserClanMemberAdvancedTooltip.NAME:
               return new MafiaUserClanMemberAdvancedTooltip(new MafiaUserClanMemberTooltip());
            case MafiaClanRankingWarStatusAdvancedTooltip.NAME:
               return new MafiaClanRankingWarStatusAdvancedTooltip(new MafiaClanRankingWarStatusTooltip());
            case MafiaActionPanelAvatarAdvancedTooltip.NAME:
               return new MafiaActionPanelAvatarAdvancedTooltip(new MafiaAvatarTooltip());
            case MafiaWorkAdvancedTooltip.NAME:
               return new MafiaWorkAdvancedTooltip(new MafiaWorkTooltip());
            case MafiaPushAttributAdvancedTooltip.NAME:
               return new MafiaPushAttributAdvancedTooltip(new MafiaPushAttributTooltip());
            case MafiaGoldAdvancedTooltip.NAME:
               return new MafiaGoldAdvancedTooltip(new MafiaGoldTooltip());
            case MafiaSlotMachineAdvancedTooltip.NAME:
               return new MafiaSlotMachineAdvancedTooltip(new MafiaSlotmachineTooltip());
            case MafiaClanBoosterAdvancedTooltip.NAME:
               return new MafiaClanBoosterAdvancedTooltip(new MafiaClanBoosterToolTip());
            case MafiaSicilianMissionAdvancedTooltip.NAME:
               return new MafiaSicilianMissionAdvancedTooltip(new MafiaSicilianMissionTooltip());
            case MafiaSicilianDungeonAdvancedTooltip.NAME:
               return new MafiaSicilianDungeonAdvancedTooltip(new MafiaSicilianGangwarTooltip());
            case MafiaSelfUpdatingTooltip.NAME:
               return new MafiaSelfUpdatingTooltip(new MafiaMultiLineTooltip());
            case MafiaGangMemberAdvancedTooltip.NAME:
               return new MafiaGangMemberAdvancedTooltip(new MafiaGangMemberTooltip());
            case MafiaRoundOfSixteenAdvancedTooltip.NAME:
               return new MafiaRoundOfSixteenAdvancedTooltip(new MafiaRoundOfSixteenTooltip());
            case MafiaAdvancedFightEquipmentTooltip.NAME:
               return new MafiaAdvancedFightEquipmentTooltip(new MafiaFightEquipmentTooltip());
            case MafiaQuestlogAdvancedTooltip.NAME:
               return new MafiaQuestlogAdvancedTooltip(new MafiaQuestlogTooltip());
            case MafiaCityQuestAdvancedTooltip.NAME:
               return new MafiaCityQuestAdvancedTooltip(new MafiaCityAdvancedTooltip());
            case MafiaCityQuestBonusTooltip.NAME:
               return new MafiaCityQuestBonusTooltip(new MafiaBonusDistrictTooltip());
            case MafiaCityDistrictTooltip.NAME:
               return new MafiaCityDistrictTooltip(new MafiaDistrictTooltip());
            default:
               throw Error("Unknown component: " + param1);
         }
      }
      
      public function getToolTip(param1:String) : MafiaAdvancedTooltip
      {
         if(this.tooltips[param1])
         {
            return this.tooltips[param1];
         }
         return null;
      }
      
      public function get tooltipLayer() : Sprite
      {
         return _tooltipLayer;
      }
   }
}
