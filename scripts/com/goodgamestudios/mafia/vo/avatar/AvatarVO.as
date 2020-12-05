package com.goodgamestudios.mafia.vo.avatar
{
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.helper.AvatarHelper;
   import com.goodgamestudios.mafia.vo.avatar.parts.BackHairAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BackgroundAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BasicAvatarPartVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BeardAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BodyAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.EarsAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.ExtraTopAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.ExtraUnderAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.EyebrowsAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.EyesAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.FaceAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.FrontHairAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.JawAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.MouthAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.NoseAvatarVO;
   import com.goodgamestudios.math.Random;
   
   public class AvatarVO
   {
       
      
      public var fronthair:FrontHairAvatarVO;
      
      public var backhair:BackHairAvatarVO;
      
      public var eyebrows:EyebrowsAvatarVO;
      
      public var eyes:EyesAvatarVO;
      
      public var nose:NoseAvatarVO;
      
      public var mouth:MouthAvatarVO;
      
      public var extraTop:ExtraTopAvatarVO;
      
      public var extraUnder:ExtraUnderAvatarVO;
      
      public var body:BodyAvatarVO;
      
      public var jaw:JawAvatarVO;
      
      public var beard:BeardAvatarVO;
      
      public var background:BackgroundAvatarVO;
      
      public var face:FaceAvatarVO;
      
      public var ears:EarsAvatarVO;
      
      public var skinColor:uint = 0;
      
      public var hairColor:uint = 0;
      
      public var lipstickColor:uint = 0;
      
      public var shirtColor:Array;
      
      public var eyeColor:uint = 0;
      
      public var eyebrowColor:uint = 0;
      
      public var extraTopColor:uint = 0;
      
      public var extraUnderColor:uint = 0;
      
      private var _gender:CharacterGender;
      
      private var _style:int;
      
      public var characterClass:CharacterClass;
      
      private var _availableWodIdsList:Array;
      
      public function AvatarVO(param1:CharacterGender, param2:Boolean = false, param3:int = 1)
      {
         this.shirtColor = [];
         super();
         this._availableWodIdsList = AvatarHelper.getWodIdLists(param1);
         this.face = new FaceAvatarVO(param1);
         this.ears = new EarsAvatarVO(param1);
         this._gender = param1;
         this._style = param3;
         this.fronthair = new FrontHairAvatarVO();
         this.backhair = new BackHairAvatarVO();
         this.eyebrows = new EyebrowsAvatarVO();
         this.eyes = new EyesAvatarVO();
         this.nose = new NoseAvatarVO();
         this.mouth = new MouthAvatarVO();
         this.extraTop = new ExtraTopAvatarVO();
         this.extraUnder = new ExtraUnderAvatarVO();
         this.body = new BodyAvatarVO();
         this.jaw = new JawAvatarVO();
         this.background = new BackgroundAvatarVO();
         if(param1 == CharacterGender.Male)
         {
            this.beard = new BeardAvatarVO();
         }
         if(param2)
         {
            this.randomChar();
         }
      }
      
      private static function isWodIdOfMalePart(param1:int) : Boolean
      {
         if(int(param1.toString().charAt(2)) >= 5)
         {
            return true;
         }
         return false;
      }
      
      private function randomChar() : void
      {
         var _loc1_:Array = null;
         switch(this._style)
         {
            case Constants_Avatarparts.STYLE_WEST:
               _loc1_ = this.gender == CharacterGender.Female?Constants_Avatarparts.RANDOM_FEMALE_CHARACTERS:Constants_Avatarparts.RANDOM_MALE_CHARACTERS;
               break;
            case Constants_Avatarparts.STYLE_ASIAN:
               _loc1_ = this.gender == this.gender == CharacterGender.Female?Constants_Avatarparts.RANDOM_ASIAN_FEMALE_CHARACTERS:Constants_Avatarparts.RANDOM_ASIAN_MALE_CHARACTERS;
         }
         var _loc2_:int = Random.integer(0,_loc1_.length);
         var _loc3_:AvatarVO = AvatarHelper.createAvatarVOFromString(_loc1_[_loc2_]);
         this.fronthair.wodID = _loc3_.fronthair.wodID;
         this.backhair.wodID = _loc3_.backhair.wodID;
         this.eyebrows.wodID = _loc3_.eyebrows.wodID;
         this.eyes.wodID = _loc3_.eyes.wodID;
         this.nose.wodID = _loc3_.nose.wodID;
         this.mouth.wodID = _loc3_.mouth.wodID;
         this.extraTop.wodID = _loc3_.extraTop.wodID;
         this.extraUnder.wodID = _loc3_.extraUnder.wodID;
         this.body.wodID = _loc3_.body.wodID;
         this.jaw.wodID = _loc3_.jaw.wodID;
         this.background.wodID = _loc3_.background.wodID;
         this.skinColor = _loc3_.skinColor;
         this.hairColor = _loc3_.hairColor;
         this.lipstickColor = _loc3_.lipstickColor;
         this.shirtColor = _loc3_.shirtColor.concat();
         this.eyeColor = _loc3_.eyeColor;
         this.eyebrowColor = _loc3_.hairColor;
         if(this.gender == CharacterGender.Male)
         {
            this.beard.wodID = _loc3_.beard.wodID;
         }
      }
      
      public function traceAllParts() : void
      {
         trace("Fronthair : " + (!!this.fronthair?this.fronthair.wodID:this.fronthair));
         trace("Backhair  : " + (!!this.backhair?this.backhair.wodID:this.backhair));
         trace("EyeBrows  : " + (!!this.eyebrows?this.eyebrows.wodID:this.eyebrows));
         trace("Eyes      : " + (!!this.eyes?this.eyes.wodID:this.eyes));
         trace("Nose      : " + (!!this.nose?this.nose.wodID:this.nose));
         trace("Mouth     : " + (!!this.mouth?this.mouth.wodID:this.mouth));
         trace("ExtraTop  : " + (!!this.extraTop?this.extraTop.wodID:this.extraTop));
         trace("ExtraUnder: " + (!!this.extraUnder?this.extraUnder.wodID:this.extraUnder));
         trace("Body      : " + (!!this.body?this.body.wodID:this.body));
         trace("Jaw       : " + (!!this.jaw?this.jaw.wodID:this.jaw));
         trace("Skincolor : " + this.skinColor);
         trace("HairColor : " + this.hairColor);
      }
      
      public function changePart(param1:String, param2:int, param3:Array) : void
      {
         var _loc5_:BasicAvatarPartVO = null;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         switch(param1)
         {
            case Constants_Avatarparts.PART_JAWS:
               _loc5_ = this.jaw;
               break;
            case Constants_Avatarparts.PART_BODYS:
               _loc5_ = this.body;
               break;
            case Constants_Avatarparts.PART_EXTRASUNDER:
               _loc5_ = this.extraUnder;
               break;
            case Constants_Avatarparts.PART_EXTRASTOP:
               _loc5_ = this.extraTop;
               break;
            case Constants_Avatarparts.PART_MOUTHS:
               _loc5_ = this.mouth;
               break;
            case Constants_Avatarparts.PART_NOSES:
               _loc5_ = this.nose;
               break;
            case Constants_Avatarparts.PART_EYES:
               _loc5_ = this.eyes;
               break;
            case Constants_Avatarparts.PART_EYEBROWS:
               _loc5_ = this.eyebrows;
               break;
            case Constants_Avatarparts.PART_FRONTHAIRS:
               _loc5_ = this.fronthair;
               break;
            case Constants_Avatarparts.PART_BACKHAIRS:
               _loc5_ = this.backhair;
               break;
            case Constants_Avatarparts.PART_BACKGROUNDS:
               _loc5_ = this.background;
         }
         if(param1 == Constants_Avatarparts.PART_BACKGROUNDS)
         {
            _loc7_ = param3.concat();
         }
         else
         {
            _loc7_ = this.filterAvatarPartsByGender(param3);
         }
         if(param1 == Constants_Avatarparts.PART_JAWS && this.gender == CharacterGender.Male)
         {
            while(_loc6_ < AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID).length)
            {
               if(this.beard.wodID == AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID)[_loc6_])
               {
                  break;
               }
               _loc6_++;
            }
            if(param2 > 0)
            {
               if(_loc6_ + param2 >= AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID).length)
               {
                  _loc6_ = 0;
               }
               else
               {
                  _loc6_++;
                  this.beard.wodID = AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID)[_loc6_];
                  return;
               }
            }
            else if(_loc6_ + param2 >= 0)
            {
               _loc6_--;
               this.beard.wodID = AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID)[_loc6_];
               return;
            }
         }
         if(_loc7_.length > 0)
         {
            for each(_loc8_ in _loc7_)
            {
               if(!this.containsWodID(this._availableWodIdsList[param1],_loc8_))
               {
                  this._availableWodIdsList[param1].push(_loc8_);
               }
            }
         }
         while(_loc4_ < this._availableWodIdsList[param1].length)
         {
            if(_loc5_.wodID == this._availableWodIdsList[param1][_loc4_])
            {
               break;
            }
            _loc4_++;
         }
         if(param2 > 0)
         {
            if(_loc4_ + param2 >= this._availableWodIdsList[param1].length)
            {
               _loc4_ = 0;
            }
            else
            {
               _loc4_++;
            }
         }
         else if(_loc4_ + param2 < 0)
         {
            _loc4_ = this._availableWodIdsList[param1].length - 1;
         }
         else
         {
            _loc4_--;
         }
         _loc5_.wodID = this._availableWodIdsList[param1][_loc4_];
         if(_loc7_.length > 0)
         {
            this._availableWodIdsList[param1].splice(this._availableWodIdsList[param1].length - 1,_loc7_.length);
         }
         if(param1 == Constants_Avatarparts.PART_JAWS && this.gender == CharacterGender.Male)
         {
            if(_loc6_ + param2 < 0)
            {
               _loc6_ = AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID).length - 1;
            }
            this.beard.wodID = AvatarHelper.getAvailableBeardsByJawWodId(this.jaw.wodID)[_loc6_];
         }
         if(param1 == Constants_Avatarparts.PART_BODYS)
         {
            this.shirtColor = Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(this.gender,this.body.wodID)[Random.integer(0,Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(this.gender,this.body.wodID).length)];
         }
         if(!this.isAvailableWodID(_loc5_.wodID,param3))
         {
            this.changePart(param1,param2,param3);
         }
      }
      
      private function containsWodID(param1:Array, param2:int) : Boolean
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function filterAvatarPartsByGender(param1:Array) : Array
      {
         var _loc4_:uint = 0;
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            if(this.gender == CharacterGender.Male == isWodIdOfMalePart(_loc4_))
            {
               _loc2_.push(_loc4_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function changeColor(param1:String, param2:int) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc3_:Array = [];
         switch(param1)
         {
            case Constants_Avatarparts.COLOR_SKIN:
               _loc4_ = this.skinColor;
               _loc3_ = Constants_Avatarparts.AVAILABLE_SKIN_COLORS;
               break;
            case Constants_Avatarparts.COLOR_HAIR:
               _loc4_ = this.hairColor;
               _loc3_ = Constants_Avatarparts.AVAILABLE_HAIR_COLORS;
               break;
            case Constants_Avatarparts.COLOR_LIPSTICK:
               _loc4_ = this.lipstickColor;
               _loc3_ = Constants_Avatarparts.AVAILABLE_LIPSTICK_COLORS;
               break;
            case Constants_Avatarparts.COLOR_SHIRT:
               _loc5_ = this.shirtColor;
               _loc3_ = Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(this.gender,this.body.wodID);
               break;
            case Constants_Avatarparts.COLOR_EYE:
               _loc4_ = this.eyeColor;
               _loc3_ = Constants_Avatarparts.AVAILABLE_EYE_COLORS;
               break;
            case Constants_Avatarparts.COLOR_EYEBROW:
               _loc4_ = this.eyebrowColor;
               _loc3_ = Constants_Avatarparts.AVAILABLE_HAIR_COLORS;
               break;
            default:
               return;
         }
         if(param2 < 0)
         {
            if(AvatarHelper.getIndexFromColorArray(_loc4_,_loc3_) + param2 < 0)
            {
               if(_loc5_)
               {
                  _loc5_ = _loc3_[_loc3_.length - 1];
               }
               else
               {
                  _loc4_ = _loc3_[_loc3_.length - 1];
               }
            }
            else if(_loc5_)
            {
               _loc5_ = _loc3_[AvatarHelper.getIndexFromColorArray(_loc5_,_loc3_) - 1];
            }
            else
            {
               _loc4_ = _loc3_[AvatarHelper.getIndexFromColorArray(_loc4_,_loc3_) - 1];
            }
         }
         else if(AvatarHelper.getIndexFromColorArray(_loc4_,_loc3_) + param2 >= _loc3_.length)
         {
            if(_loc5_)
            {
               _loc5_ = _loc3_[0];
            }
            else
            {
               _loc4_ = _loc3_[0];
            }
         }
         else if(_loc5_)
         {
            _loc5_ = _loc3_[AvatarHelper.getIndexFromColorArray(_loc5_,_loc3_) + 1];
         }
         else
         {
            _loc4_ = _loc3_[AvatarHelper.getIndexFromColorArray(_loc4_,_loc3_) + 1];
         }
         switch(param1)
         {
            case Constants_Avatarparts.COLOR_SKIN:
               this.skinColor = _loc4_;
               break;
            case Constants_Avatarparts.COLOR_HAIR:
               this.hairColor = _loc4_;
               break;
            case Constants_Avatarparts.COLOR_LIPSTICK:
               this.lipstickColor = _loc4_;
               break;
            case Constants_Avatarparts.COLOR_SHIRT:
               this.shirtColor = _loc5_;
               break;
            case Constants_Avatarparts.COLOR_EYE:
               this.eyeColor = _loc4_;
               break;
            case Constants_Avatarparts.COLOR_EYEBROW:
               this.eyebrowColor = _loc4_;
         }
      }
      
      private function isAvailableWodID(param1:int, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param2.length > 0)
         {
            for each(_loc4_ in param2)
            {
               if(_loc4_ == param1)
               {
                  return true;
               }
            }
         }
         for each(_loc3_ in Constants_Avatarparts.SPECIAL_WODIDS)
         {
            if(_loc3_ == param1)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get gender() : CharacterGender
      {
         return this._gender;
      }
   }
}
