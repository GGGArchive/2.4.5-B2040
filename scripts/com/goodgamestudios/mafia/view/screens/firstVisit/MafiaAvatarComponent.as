package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import flash.display.Sprite;
   
   public class MafiaAvatarComponent extends Sprite
   {
       
      
      private var currentAvatarVO:AvatarVO;
      
      private var _currentMaleAvatarVO:AvatarVO;
      
      private var _currentFemaleAvatarVO:AvatarVO;
      
      private var SCALE:Number = 0.55;
      
      public function MafiaAvatarComponent(param1:AvatarVO = null, param2:Number = 0)
      {
         super();
         if(param2 != 0)
         {
            this.SCALE = param2;
         }
         if(param1)
         {
            this.currentAvatarVO = param1;
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
            if(param1.characterClass == null || param1.characterClass == CharacterClass.None)
            {
               this.changeCharacterClass(CharacterClass.getRandom());
            }
         }
         else
         {
            this._currentFemaleAvatarVO = new AvatarVO(CharacterGender.Female,true);
            this._currentMaleAvatarVO = new AvatarVO(CharacterGender.Male,true);
            this.createRandomCharacter(CharacterGender.Male);
            this.changeCharacterClass(CharacterClass.getRandom());
         }
      }
      
      public function drawCharacter() : void
      {
         if(this.currentAvatarVO.gender == CharacterGender.Female)
         {
            this._currentFemaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
         }
         else
         {
            this._currentMaleAvatarVO = AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
         }
         MovieClipHelper.clearMovieClip(this);
         addChild(AvatarHelper.createAvatar(this.currentAvatarVO,this.SCALE));
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function createRandomCharacter(param1:CharacterGender) : void
      {
         var _loc2_:CharacterClass = CharacterClass.None;
         if(this.currentAvatarVO)
         {
            _loc2_ = this.currentAvatarVO.characterClass;
         }
         this.currentAvatarVO = new AvatarVO(param1,true);
         if(_loc2_ == null || _loc2_ == CharacterClass.None)
         {
            this.currentAvatarVO.characterClass = _loc2_;
         }
      }
      
      public function changeCharacter(param1:String, param2:int, param3:Array) : void
      {
         this.currentAvatarVO.changePart(param1,param2,param3);
      }
      
      public function changeColor(param1:String, param2:int) : void
      {
         this.currentAvatarVO.changeColor(param1,param2);
      }
      
      public function setColorForPart(param1:String, param2:uint, param3:uint = 0) : void
      {
         switch(param1)
         {
            case Constants_Avatarparts.COLOR_HAIR:
               this.currentAvatarVO.hairColor = param2;
               break;
            case Constants_Avatarparts.COLOR_SKIN:
               this.currentAvatarVO.skinColor = param2;
               break;
            case Constants_Avatarparts.COLOR_SHIRT:
               if(param3 == 0)
               {
                  this.currentAvatarVO.shirtColor = [param2];
               }
               else
               {
                  this.currentAvatarVO.shirtColor = [param2,param3];
               }
               break;
            case Constants_Avatarparts.COLOR_EYE:
               this.currentAvatarVO.eyeColor = param2;
               break;
            case Constants_Avatarparts.COLOR_EYEBROW:
               this.currentAvatarVO.eyebrowColor = param2;
               break;
            case Constants_Avatarparts.COLOR_LIPSTICK:
               this.currentAvatarVO.lipstickColor = param2;
         }
      }
      
      public function changeGender(param1:CharacterGender) : void
      {
         if(param1 == this.currentAvatarVO.gender)
         {
            return;
         }
         this.currentAvatarVO = AvatarHelper.cloneAvatarVO(param1 == CharacterGender.Female?this._currentFemaleAvatarVO:this._currentMaleAvatarVO);
      }
      
      public function changeCharacterClass(param1:CharacterClass) : void
      {
         if(this.currentAvatarVO.characterClass == param1)
         {
            return;
         }
         this.currentAvatarVO.characterClass = param1;
         this._currentFemaleAvatarVO.characterClass = param1;
         this._currentMaleAvatarVO.characterClass = param1;
      }
      
      public function get avatarVO() : AvatarVO
      {
         return AvatarHelper.cloneAvatarVO(this.currentAvatarVO);
      }
   }
}
