package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.MafiaTutorialController;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.MafiaAttributeCostsData;
   import com.goodgamestudios.mafia.model.components.user.MafiaProfileData;
   import com.goodgamestudios.mafia.model.components.user.MafiaUserData;
   import com.goodgamestudios.mafia.view.tooltips.MafiaArrowMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaAvatarAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaMultiLineAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.MafiaPushAttributAdvancedTooltip;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaExperienceAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaPushAttributAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.gskinner.motion.GTween;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MafiaProfileScreen extends MafiaScreen
   {
       
      
      protected var isBoostingAttribute:Boolean = false;
      
      private const DEFENCE_TOOLTIP_OFFSET:int = 50;
      
      public function MafiaProfileScreen(param1:DisplayObject)
      {
         super(param1,false);
      }
      
      public function fillUserData(param1:MafiaUserData) : void
      {
         this.mafiaBasicProfile.level_Box.mouseChildren = false;
         this.mafiaBasicProfile.level_Box.txt_level.text = String(param1.userLevel);
         this.mafiaBasicProfile.level_Box.xpBar.scaleY = param1.xpToNextLevelPercent / 100;
         this.mafiaBasicProfile.avatarPicField1.toolTipVO = new TooltipVO(MafiaAvatarAdvancedTooltip.NAME,new MafiaExperienceAdvancedTooltipProperties(param1.userXP,param1.userXPForCurrentLevel,param1.userXPForNextLevel),new Point(284,100),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override public function show() : void
      {
         super.show();
         this.mafiaBasicProfile.profileValues.visible = false;
         this.mafiaBasicProfile.profileValues.alpha = 0;
         this.mafiaBasicProfile.profileStats.visible = true;
         this.mafiaBasicProfile.profileStats.alpha = 1;
      }
      
      protected function fillAvatarStats(param1:MafiaProfileData) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = NumberStringHelper.groupString(param1.defense,MafiaModel.languageData.getTextById);
         var _loc4_:String = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon" + param1.characterClass.index);
         this.mafiaBasicProfile.btn_toFamily.toolTipText = MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_family");
         this.mafiaBasicProfile.profileStats.txt_attack.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_attack");
         this.mafiaBasicProfile.profileStats.txt_resistance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_tough");
         this.mafiaBasicProfile.profileStats.txt_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_endurance");
         this.mafiaBasicProfile.profileStats.txt_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_luck");
         if(param1.playerID == MafiaModel.userData.playerID || param1.playerID == 0)
         {
            this.fillStatResults(param1);
            _loc2_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_defence",[_loc4_,_loc3_]);
         }
         else
         {
            this.fillOtherPlayerStatResults(param1);
            _loc2_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_defenceEnemy",[_loc4_,_loc3_]);
         }
         this.mafiaBasicProfile.profileStats.txt_attack_math.text = NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileStats.txt_endurance_math.text = NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileStats.txt_luck_math.text = NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileStats.txt_resistance_math.text = NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileValues.txt_attack_math.text = NumberStringHelper.groupString(Number(param1.damage),MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileValues.txt_endurance_math.text = NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById);
         this.mafiaBasicProfile.profileValues.txt_luck_math.text = NumberStringHelper.groupString(param1.criticalHitChance,MafiaModel.languageData.getTextById) + "%";
         this.mafiaBasicProfile.profileValues.txt_resistance_math.text = NumberStringHelper.groupString(Number(param1.resistance),MafiaModel.languageData.getTextById) + "%";
         this.mafiaBasicProfile.defense.mouseChildren = false;
         this.mafiaBasicProfile.defense.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_defense");
         this.mafiaBasicProfile.defense.txt_value.text = param1.defense;
         this.mafiaBasicProfile.defense.toolTipVO = new TooltipVO(MafiaMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc2_),new Point(this.mafiaBasicProfile.defense.x,(this.mafiaBasicProfile.defense.localToGlobal(new Point()).y - this.DEFENCE_TOOLTIP_OFFSET) / layoutManager.scaleFactor),"");
         this.mafiaBasicProfile.txt_name.embedFonts = true;
         this.mafiaBasicProfile.txt_name.text = param1.name;
         if(this.mafiaBasicProfile.txt_name.textWidth == 0)
         {
            this.mafiaBasicProfile.txt_name.embedFonts = false;
            this.mafiaBasicProfile.txt_name.text = param1.name;
         }
         if(param1.clanID > 0 && param1.clanID < Constants_Basic.LOOKING_FOR_CLAN_ID)
         {
            this.mafiaBasicProfile.txt_familyname.text = param1.clanName;
         }
         else
         {
            this.mafiaBasicProfile.txt_familyname.text = "";
         }
         this.mafiaBasicProfile.txt_familyname.x = this.mafiaBasicProfile.txt_name.x + this.mafiaBasicProfile.txt_name.textWidth + 5;
         this.mafiaBasicProfile.txt_familyname.width = this.mafiaBasicProfile.btn_toFamily.x - this.mafiaBasicProfile.txt_familyname.x - this.mafiaBasicProfile.btn_toFamily.width / 2;
      }
      
      protected function fillOtherPlayerStatResults(param1:MafiaProfileData) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:String = "";
         _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
         _loc4_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attributeEnemy_attack",[NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.damage,MafiaModel.languageData.getTextById)]);
         _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_resistance");
         _loc6_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attributeEnemy_endurance",[NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById)]);
         _loc7_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attributeEnemy_luck",[NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById),param1.criticalHitChance,MafiaProfileData.maxChanceLuck]);
         _loc5_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attributeEnemy_tough",[NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById),MafiaProfileData.maxChanceResistance,param1.resistance]);
         this.mafiaBasicProfile.profileValues.txt_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_health");
         this.mafiaBasicProfile.profileValues.txt_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_crit");
         this.mafiaBasicProfile.profileValues.txt_attack.text = _loc2_;
         this.mafiaBasicProfile.profileValues.txt_resistance.text = _loc3_;
         this.mafiaBasicProfile.profileValues.attackMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc4_),new Point(this.mafiaBasicProfile.profileValues.attackMath_hoover.x,this.mafiaBasicProfile.profileValues.attackMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.resistanceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc5_),new Point(this.mafiaBasicProfile.profileValues.resistanceMath_hoover.x,this.mafiaBasicProfile.profileValues.resistanceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.enduranceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc6_),new Point(this.mafiaBasicProfile.profileValues.enduranceMath_hoover.x,this.mafiaBasicProfile.profileValues.enduranceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.luckMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc7_),new Point(this.mafiaBasicProfile.profileValues.luckMath_hoover.x,this.mafiaBasicProfile.profileValues.luckMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      protected function fillStatResults(param1:MafiaProfileData) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:String = "";
         _loc2_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
         _loc4_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_attack",[NumberStringHelper.groupString(param1.attack,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.damage,MafiaModel.languageData.getTextById)]);
         _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_resistance");
         _loc5_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_tough",[NumberStringHelper.groupString(param1.toughness,MafiaModel.languageData.getTextById),MafiaProfileData.maxChanceResistance,param1.resistance]);
         _loc6_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_endurance",[NumberStringHelper.groupString(param1.endurance,MafiaModel.languageData.getTextById),NumberStringHelper.groupString(param1.health,MafiaModel.languageData.getTextById)]);
         _loc7_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_attribute_luck",[NumberStringHelper.groupString(param1.luck,MafiaModel.languageData.getTextById),param1.criticalHitChance,MafiaProfileData.maxChanceLuck]);
         this.mafiaBasicProfile.profileValues.txt_endurance.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_health");
         this.mafiaBasicProfile.profileValues.txt_luck.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_crit");
         this.mafiaBasicProfile.profileValues.txt_attack.text = _loc2_;
         this.mafiaBasicProfile.profileValues.txt_resistance.text = _loc3_;
         this.mafiaBasicProfile.profileValues.attackMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc4_),new Point(this.mafiaBasicProfile.profileValues.attackMath_hoover.x,this.mafiaBasicProfile.profileValues.attackMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.resistanceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc5_),new Point(this.mafiaBasicProfile.profileValues.resistanceMath_hoover.x,this.mafiaBasicProfile.profileValues.resistanceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.enduranceMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc6_),new Point(this.mafiaBasicProfile.profileValues.enduranceMath_hoover.x,this.mafiaBasicProfile.profileValues.enduranceMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
         this.mafiaBasicProfile.profileValues.luckMath_hoover.toolTipVO = new TooltipVO(MafiaArrowMultiLineAdvancedTooltip.NAME,new MafiaMultiLineAdvancedTooltipProperties(_loc7_),new Point(this.mafiaBasicProfile.profileValues.luckMath_hoover.x,this.mafiaBasicProfile.profileValues.luckMath_hoover.localToGlobal(new Point()).y / layoutManager.scaleFactor),"",BasicCustomCursor.CURSOR_ARROW);
      }
      
      protected function upgradeAttribute(param1:int) : void
      {
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_1:
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_2:
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_3:
                  MafiaTutorialController.getInstance().nextStep();
               default:
                  return;
            }
         }
         if(param1 == 0)
         {
            return;
         }
         this.isBoostingAttribute = true;
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_UPGRADE_ATTRIBUTE,[param1]);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(MafiaTutorialController.getInstance().isActive)
         {
            switch(MafiaTutorialController.getInstance().tutorialState)
            {
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_1:
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_2:
               case MafiaTutorialController.TUT_STATE_UPGRADE_ATTRIBUTES_3:
                  if(!(param1.target == this.mafiaBasicProfile.btn_addAttack || param1.target == this.mafiaBasicProfile.btn_addEndurance || param1.target == this.mafiaBasicProfile.btn_addLuck || param1.target == this.mafiaBasicProfile.btn_addResistance))
                  {
                     return;
                  }
               default:
                  return;
            }
         }
         switch(param1.target)
         {
            case this.mafiaBasicProfile.btn_addAttack:
               this.upgradeAttribute(1);
               break;
            case this.mafiaBasicProfile.btn_addEndurance:
               this.upgradeAttribute(2);
               break;
            case this.mafiaBasicProfile.btn_addLuck:
               this.upgradeAttribute(3);
               break;
            case this.mafiaBasicProfile.btn_addResistance:
               this.upgradeAttribute(4);
         }
         super.onClick(param1);
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         super.onMouseDown(param1);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is Btn_StatMathHoover)
         {
            this.blendToStatValues();
         }
         switch(param1.target)
         {
            case this.mafiaBasicProfile.bg:
               break;
            case this.mafiaBasicProfile.defence:
               super.onMouseOver(param1);
               layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
               break;
            case this.mafiaBasicProfile.btn_addAttack:
               this.showBoostTooltip(param1.target as MovieClip,MafiaModel.userData.attributsCostsData,1);
               break;
            case this.mafiaBasicProfile.btn_addEndurance:
               this.showBoostTooltip(param1.target as MovieClip,MafiaModel.userData.attributsCostsData,2);
               break;
            case this.mafiaBasicProfile.btn_addLuck:
               this.showBoostTooltip(param1.target as MovieClip,MafiaModel.userData.attributsCostsData,3);
               break;
            case this.mafiaBasicProfile.btn_addResistance:
               this.showBoostTooltip(param1.target as MovieClip,MafiaModel.userData.attributsCostsData,4);
               break;
            default:
               super.onMouseOver(param1);
         }
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.mafiaBasicProfile.btn_addAttack:
            case this.mafiaBasicProfile.btn_addEndurance:
            case this.mafiaBasicProfile.btn_addLuck:
            case this.mafiaBasicProfile.btn_addResistance:
               this.isBoostingAttribute = false;
               layoutManager.tooltipManager.hideAdvancedTooltip();
         }
         super.onMouseOut(param1);
      }
      
      protected function showBoostTooltip(param1:MovieClip, param2:MafiaAttributeCostsData, param3:int) : void
      {
         this.isBoostingAttribute = true;
         var _loc4_:TooltipVO = new TooltipVO(MafiaPushAttributAdvancedTooltip.NAME,new MafiaPushAttributAdvancedTooltipProperties(param2,param3),new Point(param1.x,param1.y - 20),"",BasicCustomCursor.CURSOR_CLICK);
         layoutManager.tooltipManager.showAdvancedTooltip(_loc4_);
      }
      
      protected function blendToStatValues() : void
      {
         var _loc1_:GTween = null;
         if(this.mafiaBasicProfile.profileStats.alpha == 1)
         {
            _loc1_ = new GTween(this.mafiaBasicProfile.profileStats,0.2,{"alpha":0});
            _loc1_.onComplete = this.onProfileStatsTweenComplete;
            this.mafiaBasicProfile.profileValues.addEventListener(MouseEvent.ROLL_OUT,this.onOutProfileStats);
         }
      }
      
      protected function onOutProfileStats(param1:MouseEvent) : void
      {
         this.mafiaBasicProfile.profileValues.removeEventListener(MouseEvent.ROLL_OUT,this.onOutProfileStats);
         var _loc2_:GTween = new GTween(this.mafiaBasicProfile.profileValues,0.2,{"alpha":0});
         _loc2_.onComplete = this.onProfileValuesTweenComplete;
      }
      
      protected function onProfileStatsTweenComplete(param1:GTween) : void
      {
         this.mafiaBasicProfile.profileStats.visible = false;
         this.mafiaBasicProfile.profileValues.alpha = 0;
         this.mafiaBasicProfile.profileValues.visible = true;
         new GTween(this.mafiaBasicProfile.profileValues,0.2,{"alpha":1});
      }
      
      protected function onProfileValuesTweenComplete(param1:GTween) : void
      {
         this.mafiaBasicProfile.profileValues.visible = false;
         this.mafiaBasicProfile.profileStats.alpha = 0;
         this.mafiaBasicProfile.profileStats.visible = true;
         new GTween(this.mafiaBasicProfile.profileStats,0.2,{"alpha":1});
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      protected function get mafiaBasicProfile() : MovieClip
      {
         return disp as MovieClip;
      }
   }
}
