package com.goodgamestudios.mafia.view.screens
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.Constants_Background;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.screens.firstVisit.FirstVisitColorTooltipMovieclip;
   import com.goodgamestudios.mafia.view.screens.firstVisit.MafiaDataHolder;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextFieldType;
   import flash.utils.getDefinitionByName;
   
   public class MafiaCustomizeAvatarScreen extends MafiaScreen
   {
      
      public static const NAME:String = "MafiaCustomizeAvatarScreen";
       
      
      private var currentAvatarVO:AvatarVO;
      
      private const SCALE:Number = 0.5;
      
      private var currentColorTooltip:FirstVisitColorTooltipMovieclip;
      
      private var _currentMaleAvatarVO:AvatarVO;
      
      private var _currentFemaleAvatarVO:AvatarVO;
      
      private var _defaultNameString:String;
      
      private var isWaitingForServerMessage:Boolean;
      
      public function MafiaCustomizeAvatarScreen(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function get screenBackgroundId() : String
      {
         return MafiaModel.userData.profileData.city.index + "_" + Constants_Background.BG_CUSTOMIZE.toString();
      }
      
      override protected function applyProperties() : void
      {
         this.customScreen.txt_name.text = MafiaModel.userData.profileData.name;
         this.customScreen.txt_familyname.text = MafiaModel.userData.profileData.clanName;
         updateAllTextFields();
         this.customScreen.mc_backhair_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_hairback");
         this.customScreen.mc_backgrounds_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_background");
         this.customScreen.mc_body_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_body");
         this.customScreen.mc_extraTop_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_extraone");
         this.customScreen.mc_extraunder_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_extratwo");
         this.customScreen.mc_eyebrows_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_eyebrows");
         this.customScreen.mc_eyes_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_eyes");
         this.customScreen.mc_fronthair_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_hairfront");
         this.customScreen.mc_jaw_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_jaw");
         this.customScreen.mc_mouth_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_mouth");
         this.customScreen.mc_nose_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_nose");
         this.customScreen.mc_skin_icon.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_category_skincolor");
         this.customScreen.btn_male.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_male");
         this.customScreen.btn_female.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_female");
         this.customScreen.btn_random.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_random");
         this.customScreen.btn_haircolor.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_colorchange");
         this.customScreen.btn_shirtcolor.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_colorchange");
         this.customScreen.btn_eyeBrowColor.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_colorchange");
         this.customScreen.btn_eyecolor.toolTipText = MafiaModel.languageData.getTextById("tt_MafiaCustomizeAvatarScreen_colorchange");
      }
      
      override public function show() : void
      {
         super.show();
         if(MafiaModel.userData.profileData.avatarChangeFree)
         {
            this.customScreen.btn_ok.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
         }
         else
         {
            this.customScreen.btn_ok.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
            this.customScreen.btn_ok.goldInfoVisible = true;
            this.customScreen.btn_ok.goldInfoTimeText = MafiaModel.goldConstants.changeAvatarPrice.toString();
         }
         if(MafiaModel.userData.profileData.picString.length > 2)
         {
            this.currentAvatarVO = AvatarHelper.createAvatarVOFromString(MafiaModel.userData.profileData.picString);
            if(this.currentAvatarVO.gender == CharacterGender.Female)
            {
               this._currentFemaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
               this._currentMaleAvatarVO = new AvatarVO(CharacterGender.Male,true);
            }
            else
            {
               this._currentMaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
               this._currentFemaleAvatarVO = new AvatarVO(CharacterGender.Female,true);
            }
         }
         else
         {
            this._currentFemaleAvatarVO = new AvatarVO(CharacterGender.Female,true);
            this._currentMaleAvatarVO = new AvatarVO(CharacterGender.Male,true);
            this.currentAvatarVO = AvatarHelper.cloneAvatarVO(env.gender == "female"?this._currentFemaleAvatarVO:this._currentMaleAvatarVO);
         }
         if(this.currentAvatarVO.gender == CharacterGender.Male && Constants_Avatarparts.MALE_EXTRASTOP_AVAILABLE == 0)
         {
            this.customScreen.btn_extratop_left.enableButton = false;
            this.customScreen.btn_extratop_right.enableButton = false;
         }
         this.currentAvatarVO.characterClass = MafiaModel.userData.profileData.characterClass;
         this.customScreen.btn_back.label = MafiaModel.languageData.getTextById("generic_btn_goback");
         this.drawCharacter();
         this.checkOKButton();
      }
      
      override public function hide() : void
      {
         this.clearToolTips();
         super.hide();
      }
      
      override public function destroy() : void
      {
         this.clearToolTips();
         super.destroy();
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         if(param1.target == this.customScreen.txt_name)
         {
            if(this.customScreen.txt_name.type == TextFieldType.INPUT && this.customScreen.txt_name.text == this._defaultNameString)
            {
               this.customScreen.txt_name.text = "";
            }
         }
         switch(param1.target)
         {
            case this.customScreen.btn_fronthair_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_FRONTHAIRS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsFronthairs);
               this.drawCharacter();
               break;
            case this.customScreen.btn_fronthair_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_FRONTHAIRS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsFronthairs);
               this.drawCharacter();
               break;
            case this.customScreen.btn_backhair_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKHAIRS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackhairs);
               this.drawCharacter();
               break;
            case this.customScreen.btn_backhair_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKHAIRS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackhairs);
               this.drawCharacter();
               break;
            case this.customScreen.btn_eyebrows_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYEBROWS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyebrows);
               this.drawCharacter();
               break;
            case this.customScreen.btn_eyebrows_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYEBROWS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyebrows);
               this.drawCharacter();
               break;
            case this.customScreen.btn_eyes_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYES,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyes);
               this.drawCharacter();
               break;
            case this.customScreen.btn_eyes_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYES,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyes);
               this.drawCharacter();
               break;
            case this.customScreen.btn_nose_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_NOSES,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsNoses);
               this.drawCharacter();
               break;
            case this.customScreen.btn_nose_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_NOSES,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsNoses);
               this.drawCharacter();
               break;
            case this.customScreen.btn_mouth_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_MOUTHS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsMouths);
               this.drawCharacter();
               break;
            case this.customScreen.btn_mouth_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_MOUTHS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsMouths);
               this.drawCharacter();
               break;
            case this.customScreen.btn_extratop_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASTOP,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasTop);
               this.drawCharacter();
               break;
            case this.customScreen.btn_extratop_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASTOP,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasTop);
               this.drawCharacter();
               break;
            case this.customScreen.btn_extraunder_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASUNDER,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasUnder);
               this.drawCharacter();
               break;
            case this.customScreen.btn_extraunder_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASUNDER,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasUnder);
               this.drawCharacter();
               break;
            case this.customScreen.btn_jaw_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_JAWS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsJaws);
               this.drawCharacter();
               break;
            case this.customScreen.btn_jaw_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_JAWS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsJaws);
               this.drawCharacter();
               break;
            case this.customScreen.btn_body_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BODYS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBodies);
               this.drawCharacter();
               break;
            case this.customScreen.btn_body_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BODYS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBodies);
               this.drawCharacter();
               break;
            case this.customScreen.btn_background_left:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKGROUNDS,-1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackgrounds);
               this.drawCharacter();
               break;
            case this.customScreen.btn_background_right:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKGROUNDS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackgrounds);
               this.drawCharacter();
               break;
            case this.customScreen.btn_skincolor_left:
               this.currentAvatarVO.changeColor(Constants_Avatarparts.COLOR_SKIN,-1);
               this.drawCharacter();
               break;
            case this.customScreen.btn_skincolor_right:
               this.currentAvatarVO.changeColor(Constants_Avatarparts.COLOR_SKIN,1);
               this.drawCharacter();
               break;
            case this.customScreen.mc_backhair_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKHAIRS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackhairs);
               this.drawCharacter();
               break;
            case this.customScreen.mc_body_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BODYS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBodies);
               this.drawCharacter();
               break;
            case this.customScreen.mc_extraTop_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASTOP,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasTop);
               this.drawCharacter();
               break;
            case this.customScreen.mc_extraunder_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EXTRASUNDER,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsExtrasUnder);
               this.drawCharacter();
               break;
            case this.customScreen.mc_backgrounds_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_BACKGROUNDS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsBackgrounds);
               this.drawCharacter();
               break;
            case this.customScreen.mc_eyebrows_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYEBROWS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyebrows);
               this.drawCharacter();
               break;
            case this.customScreen.mc_eyes_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_EYES,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsEyes);
               this.drawCharacter();
               break;
            case this.customScreen.mc_fronthair_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_FRONTHAIRS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsFronthairs);
               this.drawCharacter();
               break;
            case this.customScreen.mc_jaw_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_JAWS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsJaws);
               this.drawCharacter();
               break;
            case this.customScreen.mc_mouth_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_MOUTHS,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsMouths);
               this.drawCharacter();
               break;
            case this.customScreen.mc_nose_icon:
               this.currentAvatarVO.changePart(Constants_Avatarparts.PART_NOSES,1,MafiaModel.userData.unlockedAssetsData.specialAvatarPartsNoses);
               this.drawCharacter();
               break;
            case this.customScreen.mc_skin_icon:
               this.currentAvatarVO.changeColor(Constants_Avatarparts.COLOR_SKIN,1);
               this.drawCharacter();
               break;
            case this.customScreen.btn_haircolor:
               if(this.currentColorTooltip && this.currentColorTooltip.type == Constants_Avatarparts.COLOR_HAIR)
               {
                  break;
               }
               if(this.currentColorTooltip)
               {
                  this.clearToolTips();
               }
               this.currentColorTooltip = new FirstVisitColorTooltipMovieclip(Constants_Avatarparts.AVAILABLE_HAIR_COLORS,this.customScreen.btn_haircolor,layoutManager.panelSprite,Constants_Avatarparts.COLOR_HAIR,this.onClickColorButton);
               return;
            case this.customScreen.btn_shirtcolor:
               if(this.currentColorTooltip && this.currentColorTooltip.type == Constants_Avatarparts.COLOR_SHIRT)
               {
                  break;
               }
               if(this.currentColorTooltip)
               {
                  this.clearToolTips();
               }
               this.currentColorTooltip = new FirstVisitColorTooltipMovieclip(Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(this.currentAvatarVO.gender,this.currentAvatarVO.body.wodID),this.customScreen.btn_shirtcolor,layoutManager.panelSprite,Constants_Avatarparts.COLOR_SHIRT,this.onClickColorButton);
               return;
            case this.customScreen.btn_eyecolor:
               if(this.currentColorTooltip && this.currentColorTooltip.type == Constants_Avatarparts.COLOR_EYE)
               {
                  break;
               }
               if(this.currentColorTooltip)
               {
                  this.clearToolTips();
               }
               this.currentColorTooltip = new FirstVisitColorTooltipMovieclip(Constants_Avatarparts.AVAILABLE_EYE_COLORS,this.customScreen.btn_eyecolor,layoutManager.panelSprite,Constants_Avatarparts.COLOR_EYE,this.onClickColorButton);
               return;
            case this.customScreen.btn_eyeBrowColor:
               if(this.currentColorTooltip && this.currentColorTooltip.type == Constants_Avatarparts.COLOR_EYEBROW)
               {
                  break;
               }
               if(this.currentColorTooltip)
               {
                  this.clearToolTips();
               }
               this.currentColorTooltip = new FirstVisitColorTooltipMovieclip(Constants_Avatarparts.AVAILABLE_HAIR_COLORS,this.customScreen.btn_eyeBrowColor,layoutManager.panelSprite,Constants_Avatarparts.COLOR_EYEBROW,this.onClickColorButton);
               return;
            case this.customScreen.btn_lipstick_color:
               if(this.currentColorTooltip && this.currentColorTooltip.type == Constants_Avatarparts.COLOR_LIPSTICK)
               {
                  break;
               }
               if(this.currentColorTooltip)
               {
                  this.clearToolTips();
               }
               this.currentColorTooltip = new FirstVisitColorTooltipMovieclip(Constants_Avatarparts.AVAILABLE_LIPSTICK_COLORS,this.customScreen.btn_lipstick_color,layoutManager.panelSprite,Constants_Avatarparts.COLOR_LIPSTICK,this.onClickColorButton);
               return;
            case this.customScreen.btn_male:
               this.changeGender(CharacterGender.Male);
               break;
            case this.customScreen.btn_female:
               this.changeGender(CharacterGender.Female);
               break;
            case this.customScreen.btn_random:
               this.createRandomCharacter(this.currentAvatarVO.gender);
               break;
            case this.customScreen.btn_ok:
               this.onClickOk();
               break;
            case this.customScreen.btn_back:
               layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
         }
         if(this.currentColorTooltip && !(param1.target is (getDefinitionByName("ColorPopup") as Class)))
         {
            this.clearToolTips();
         }
      }
      
      private function onClickOk() : void
      {
         if(!this.customScreen.btn_ok.enabled)
         {
            return;
         }
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_CHANGE_AVATAR,[AvatarHelper.createSFStringFromAvatarVO(this.currentAvatarVO)]);
         MafiaDataHolder.instance.savedAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
         layoutManager.state = Constants_LayoutStates.STATE_PROFILE;
      }
      
      private function checkOKButton() : void
      {
         this.customScreen.btn_ok.enableButton = true;
         if(MafiaModel.userData.profileData.avatarChangeFree)
         {
            this.customScreen.btn_ok.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
         }
         else
         {
            this.customScreen.btn_ok.label = MafiaModel.languageData.getTextById("generic_register_btn_save");
            this.customScreen.btn_ok.goldInfoVisible = true;
            this.customScreen.btn_ok.goldInfoTimeText = MafiaModel.goldConstants.changeAvatarPrice.toString();
         }
         if(AvatarHelper.areEqual(this.currentAvatarVO,AvatarHelper.createAvatarVOFromString(MafiaModel.userData.profileData.picString)))
         {
            this.customScreen.btn_ok.enableButton = false;
         }
         updateAllTextFields();
         this.customScreen.btn_ok.update();
      }
      
      override public function checkWaitingAnimState(param1:String) : void
      {
         if(param1 == Constants_SFS.C2S_LOGIN_SET_NAME)
         {
            this.isWaitingForServerMessage = false;
         }
      }
      
      public function onClickColorButton(param1:uint, param2:uint = 0) : void
      {
         switch(this.currentColorTooltip.type)
         {
            case Constants_Avatarparts.COLOR_HAIR:
               this.currentAvatarVO.hairColor = param1;
               break;
            case Constants_Avatarparts.COLOR_SKIN:
               this.currentAvatarVO.skinColor = param1;
               break;
            case Constants_Avatarparts.COLOR_SHIRT:
               if(param2 == 0)
               {
                  this.currentAvatarVO.shirtColor = [param1];
               }
               else
               {
                  this.currentAvatarVO.shirtColor = [param1,param2];
               }
               break;
            case Constants_Avatarparts.COLOR_EYE:
               this.currentAvatarVO.eyeColor = param1;
               break;
            case Constants_Avatarparts.COLOR_EYEBROW:
               this.currentAvatarVO.eyebrowColor = param1;
               break;
            case Constants_Avatarparts.COLOR_LIPSTICK:
               this.currentAvatarVO.lipstickColor = param1;
         }
         this.drawCharacter();
      }
      
      private function clearToolTips() : void
      {
         if(this.currentColorTooltip)
         {
            this.currentColorTooltip.destroy();
         }
         this.currentColorTooltip = null;
      }
      
      private function changeGender(param1:CharacterGender) : void
      {
         if(param1 == this.currentAvatarVO.gender)
         {
            return;
         }
         if(param1 == CharacterGender.Female)
         {
            this.currentAvatarVO = AvatarHelper.cloneAvatarVO(this._currentFemaleAvatarVO);
         }
         else
         {
            this.currentAvatarVO = AvatarHelper.cloneAvatarVO(this._currentMaleAvatarVO);
         }
         this.drawCharacter();
      }
      
      private function createRandomCharacter(param1:CharacterGender) : void
      {
         this.currentAvatarVO = new AvatarVO(param1,true);
         this.drawCharacter();
      }
      
      private function drawCharacter() : void
      {
         if(this.currentAvatarVO.gender == CharacterGender.Female)
         {
            this._currentFemaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
         }
         else
         {
            this._currentMaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
         }
         this.customScreen.btn_male.isFixed = this.currentAvatarVO.gender == CharacterGender.Male;
         this.customScreen.btn_female.isFixed = this.currentAvatarVO.gender == CharacterGender.Female;
         var _loc1_:ColorTransform = new ColorTransform();
         _loc1_.color = this.currentAvatarVO.hairColor;
         this.customScreen.btn_haircolor.cc.transform.colorTransform = _loc1_;
         this.customScreen.btn_haircolor.cc1.transform.colorTransform = _loc1_;
         _loc1_.color = this.currentAvatarVO.eyebrowColor;
         this.customScreen.btn_eyeBrowColor.cc.transform.colorTransform = _loc1_;
         this.customScreen.btn_eyeBrowColor.cc1.transform.colorTransform = _loc1_;
         if(this.currentAvatarVO.shirtColor.length == 2)
         {
            _loc1_.color = this.currentAvatarVO.shirtColor[0];
            this.customScreen.btn_shirtcolor.cc.transform.colorTransform = _loc1_;
            _loc1_.color = this.currentAvatarVO.shirtColor[1];
            this.customScreen.btn_shirtcolor.cc1.transform.colorTransform = _loc1_;
         }
         else
         {
            _loc1_.color = this.currentAvatarVO.shirtColor[0];
            this.customScreen.btn_shirtcolor.cc.transform.colorTransform = _loc1_;
            this.customScreen.btn_shirtcolor.cc1.transform.colorTransform = _loc1_;
         }
         _loc1_.color = this.currentAvatarVO.eyeColor;
         this.customScreen.btn_eyecolor.cc.transform.colorTransform = _loc1_;
         this.customScreen.btn_eyecolor.cc1.transform.colorTransform = _loc1_;
         this.customScreen.mc_jaw_icon.gotoAndStop(this.currentAvatarVO.gender.index);
         MovieClipHelper.clearMovieClip(this.customScreen.mc_avatarHolder);
         this.customScreen.mc_avatarHolder.addChild(AvatarHelper.createAvatar(this.currentAvatarVO,this.SCALE));
         this.customScreen.mc_avatarHolder.mouseChildren = false;
         this.customScreen.mc_avatarHolder.mouseEnabled = false;
         this.checkOKButton();
      }
      
      private function get customScreen() : MafiaCustomizeAvatar
      {
         return disp as MafiaCustomizeAvatar;
      }
   }
}
