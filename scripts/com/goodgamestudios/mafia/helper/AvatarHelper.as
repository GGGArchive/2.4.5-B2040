package com.goodgamestudios.mafia.helper
{
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Avatarparts;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.CharacterGender;
   import com.goodgamestudios.mafia.vo.avatar.AvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BackHairAvatarVO;
   import com.goodgamestudios.mafia.vo.avatar.parts.BackgroundAvatarVO;
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
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.utils.getDefinitionByName;
   
   public class AvatarHelper
   {
       
      
      public function AvatarHelper()
      {
         super();
      }
      
      public static function createAvatar(param1:AvatarVO, param2:Number = 1.0, param3:Boolean = true, param4:Number = 1) : Sprite
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:Loader = null;
         var _loc5_:Sprite = new Sprite();
         var _loc6_:int = !!param3?0:1;
         while(_loc6_ < Constants_Avatarparts.AVATARPART_ORDER.length)
         {
            _loc8_ = getWodByClass(param1,Constants_Avatarparts.AVATARPART_ORDER[_loc6_]);
            if(!(_loc8_ == -1 || _loc8_ == 0))
            {
               if(partIsLoaded(_loc8_))
               {
                  _loc9_ = getPartDispByWodId(_loc8_);
                  if(_loc9_.cc)
                  {
                     switch(Constants_Avatarparts.AVATARPART_ORDER[_loc6_])
                     {
                        case EyebrowsAvatarVO:
                           setColor(_loc9_,param1.eyebrowColor);
                           break;
                        case BackHairAvatarVO:
                        case FrontHairAvatarVO:
                        case BeardAvatarVO:
                           setColor(_loc9_,param1.hairColor);
                           break;
                        case BodyAvatarVO:
                           setColor(_loc9_,param1.skinColor,param1.shirtColor[0],!!param1.shirtColor[1]?uint(param1.shirtColor[1]):uint(0));
                           break;
                        case EarsAvatarVO:
                        case JawAvatarVO:
                        case FaceAvatarVO:
                           setColor(_loc9_,param1.skinColor);
                           break;
                        case EyesAvatarVO:
                           setColor(_loc9_,param1.eyeColor);
                     }
                  }
                  _loc7_ = _loc9_;
               }
               else
               {
                  _loc10_ = SWFLoaderHelper.instance.loadSWF(env.getAvatarSwfUrlByWodId(_loc8_),onCompleteLoading);
                  switch(Constants_Avatarparts.AVATARPART_ORDER[_loc6_])
                  {
                     case EyebrowsAvatarVO:
                        _loc10_.name = "" + param1.eyebrowColor;
                        break;
                     case BackHairAvatarVO:
                     case FrontHairAvatarVO:
                     case BeardAvatarVO:
                        _loc10_.name = "" + param1.hairColor;
                        break;
                     case BodyAvatarVO:
                        _loc10_.name = param1.skinColor + "~" + param1.shirtColor[0] + (param1.shirtColor.length == 2?"~" + param1.shirtColor[1]:"");
                        break;
                     case EarsAvatarVO:
                     case JawAvatarVO:
                     case FaceAvatarVO:
                        _loc10_.name = "" + param1.skinColor;
                        break;
                     case EyesAvatarVO:
                        _loc10_.name = "" + param1.eyeColor;
                  }
                  _loc7_ = new Sprite();
                  (_loc7_ as Sprite).addChild(_loc10_);
               }
               if(_loc6_ == 0 && param4 > 1)
               {
                  _loc7_.y = 0 + _loc7_.height / 10;
                  _loc7_.scaleX = _loc7_.scaleY = param4;
               }
               _loc5_.addChild(_loc7_);
            }
            _loc6_++;
         }
         _loc5_.scaleX = _loc5_.scaleY = param2;
         _loc5_.cacheAsBitmap = true;
         return _loc5_;
      }
      
      public static function createOldAvatar(param1:String, param2:Number = 1.0) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Class = getDefinitionByName("AP" + param1) as Class;
         _loc3_ = new _loc4_();
         if(param2 != Constants_ViewScales.SCALE_OLD_AVATARPICS_IN_FIGHT)
         {
            _loc3_.scaleX = _loc3_.scaleY = param2;
         }
         else
         {
            _loc3_.scaleX = _loc3_.scaleY = Constants_ViewScales.SCALE_OLD_AVATARPICS_IN_FIGHT;
         }
         _loc3_.cacheAsBitmap = true;
         return _loc3_;
      }
      
      public static function createClassSymbol(param1:CharacterClass, param2:Number = 0.6) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         var _loc4_:Class = getDefinitionByName("CT" + param1.index) as Class;
         _loc3_ = new _loc4_();
         if(param2 != Constants_ViewScales.SCALE_CLASSSYMBOLS_IN_FIGHT)
         {
            _loc3_.scaleX = _loc3_.scaleY = param2;
         }
         else
         {
            _loc3_.scaleX = _loc3_.scaleY = Constants_ViewScales.SCALE_CLASSSYMBOLS_IN_FIGHT;
         }
         _loc3_.mouseEnabled = false;
         _loc3_.cacheAsBitmap = true;
         return _loc3_;
      }
      
      private static function setColor(param1:MovieClip, param2:uint = 0, param3:uint = 0, param4:uint = 0) : void
      {
         if(!param1.cc)
         {
            return;
         }
         var _loc5_:ColorTransform = new ColorTransform();
         _loc5_.color = param2;
         param1.cc.transform.colorTransform = _loc5_;
         if(!param1.cc1)
         {
            return;
         }
         _loc5_.color = param3;
         param1.cc1.transform.colorTransform = _loc5_;
         if(!param1.cc2)
         {
            return;
         }
         _loc5_.color = param4;
         param1.cc2.transform.colorTransform = _loc5_;
      }
      
      private static function getWodByClass(param1:AvatarVO, param2:Class) : int
      {
         switch(param2)
         {
            case BackHairAvatarVO:
               return param1.backhair.wodID;
            case BodyAvatarVO:
               return param1.body.wodID;
            case EarsAvatarVO:
               return param1.ears.wodID;
            case JawAvatarVO:
               return param1.jaw.wodID;
            case FaceAvatarVO:
               return param1.face.wodID;
            case ExtraUnderAvatarVO:
               return param1.extraUnder.wodID;
            case EyesAvatarVO:
               return param1.eyes.wodID;
            case EyebrowsAvatarVO:
               return param1.eyebrows.wodID;
            case NoseAvatarVO:
               return param1.nose.wodID;
            case MouthAvatarVO:
               return param1.mouth.wodID;
            case ExtraTopAvatarVO:
               return param1.extraTop.wodID;
            case FrontHairAvatarVO:
               return param1.fronthair.wodID;
            case BackgroundAvatarVO:
               return param1.background.wodID;
            case BeardAvatarVO:
               if(param1.beard)
               {
                  return param1.beard.wodID;
               }
               return 0;
            default:
               return 0;
         }
      }
      
      private static function onCompleteLoading(param1:Event) : void
      {
         var _loc11_:Array = null;
         var _loc2_:DisplayObjectContainer = (param1.target as LoaderInfo).loader.parent;
         _loc2_.removeChild((param1.target as LoaderInfo).loader);
         var _loc3_:int = (param1.target as LoaderInfo).url.lastIndexOf("/");
         var _loc4_:int = (param1.target as LoaderInfo).url.lastIndexOf(".");
         var _loc5_:String = (param1.target as LoaderInfo).url.substring(_loc3_ + 1,_loc4_);
         var _loc6_:MovieClip = new (getDefinitionByName(_loc5_) as Class)() as MovieClip;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:String = (param1.target as LoaderInfo).loader.name;
         if(_loc10_.indexOf("~") == -1)
         {
            _loc7_ = uint(_loc10_);
         }
         else
         {
            _loc11_ = _loc10_.split("~");
            _loc7_ = uint(_loc11_[0]);
            _loc8_ = uint(_loc11_[1]);
            if(_loc11_[2])
            {
               _loc9_ = uint(_loc11_[2]);
            }
         }
         if(_loc6_.cc)
         {
            setColor(_loc6_,_loc7_,_loc8_,_loc9_);
         }
         _loc2_.addChild(_loc6_);
      }
      
      private static function partIsLoaded(param1:int) : Boolean
      {
         return SWFLoaderHelper.instance.isSWFLoaded(env.getAvatarSwfUrlByWodId(param1));
      }
      
      private static function getPartDispByWodId(param1:int) : MovieClip
      {
         return new (getDefinitionByName("AvaPart_" + param1) as Class)() as MovieClip;
      }
      
      public static function createAvatarVOFromString(param1:String) : AvatarVO
      {
         var avatarVO:AvatarVO = null;
         var params:Array = null;
         var gender:CharacterGender = null;
         var colorArray:Array = null;
         var wodindi:Array = null;
         var shirtColorIndex:int = 0;
         var sfString:String = param1;
         var p1:String = "!";
         var p2:String = "~";
         try
         {
            params = sfString.split(p1);
            gender = CharacterGender.getById(int(params[0]));
            colorArray = params[1].split(p2);
            wodindi = params[2].split(p2);
            avatarVO = new AvatarVO(gender);
            avatarVO.skinColor = Constants_Avatarparts.AVAILABLE_SKIN_COLORS[int(colorArray.shift())];
            avatarVO.hairColor = Constants_Avatarparts.AVAILABLE_HAIR_COLORS[int(colorArray.shift())];
            avatarVO.eyeColor = Constants_Avatarparts.AVAILABLE_EYE_COLORS[int(colorArray.shift())];
            avatarVO.eyebrowColor = Constants_Avatarparts.AVAILABLE_HAIR_COLORS[int(colorArray.shift())];
            shirtColorIndex = int(colorArray.shift());
            avatarVO.lipstickColor = Constants_Avatarparts.AVAILABLE_LIPSTICK_COLORS[int(colorArray.shift())];
            avatarVO.extraTopColor = Constants_Avatarparts.AVAILABLE_EXTRASTOP_COLORS[int(colorArray.shift())];
            avatarVO.extraUnderColor = Constants_Avatarparts.AVAILABLE_EXTRASUNDER_COLORS[int(colorArray.shift())];
            if(wodindi[0] > 0)
            {
               avatarVO.backhair.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_BACKHAIR_STARTWODID:Constants_Avatarparts.FEMALE_BACKHAIR_STARTWODID) + int(wodindi.shift()) - 1;
            }
            else
            {
               wodindi.shift();
            }
            avatarVO.body.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_BODY_STARTWODID:Constants_Avatarparts.FEMALE_BODY_STARTWODID) + int(wodindi.shift());
            avatarVO.jaw.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_JAW_STARTWODID:Constants_Avatarparts.FEMALE_JAW_STARTWODID) + int(wodindi.shift());
            if(avatarVO.gender == CharacterGender.Male)
            {
               if(wodindi[0] > 0)
               {
                  avatarVO.beard.wodID = Constants_Avatarparts.MALE_BEARD_STARTWODID + int(wodindi.shift()) - 1;
               }
               else
               {
                  wodindi.shift();
               }
            }
            if(wodindi[0] > 0)
            {
               avatarVO.extraUnder.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_EXTRASUNDER_STARTWODID:Constants_Avatarparts.FEMALE_EXTRASUNDER_STARTWODID) + int(wodindi.shift()) - 1;
            }
            else
            {
               wodindi.shift();
            }
            avatarVO.eyes.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_EYES_STARTWODID:Constants_Avatarparts.FEMALE_EYES_STARTWODID) + int(wodindi.shift());
            avatarVO.eyebrows.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_EYEBROWS_STARTWODID:Constants_Avatarparts.FEMALE_EYEBROWS_STARTWODID) + int(wodindi.shift());
            avatarVO.nose.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_NOSES_STARTWODID:Constants_Avatarparts.FEMALE_NOSES_STARTWODID) + int(wodindi.shift());
            avatarVO.mouth.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_MOUTHS_STARTWODID:Constants_Avatarparts.FEMALE_MOUTHS_STARTWODID) + int(wodindi.shift());
            if(wodindi[0] > 0)
            {
               avatarVO.extraTop.wodID = (gender == CharacterGender.Male?Constants_Avatarparts.MALE_EXTRASTOP_STARTWODID:Constants_Avatarparts.FEMALE_EXTRASTOP_STARTWODID) + int(wodindi.shift()) - 1;
            }
            else
            {
               wodindi.shift();
            }
            if(gender == CharacterGender.Male)
            {
               if(wodindi[0] > 0)
               {
                  avatarVO.fronthair.wodID = Constants_Avatarparts.MALE_FRONTHAIR_STARTWODID + int(wodindi.shift()) - 1;
               }
               else
               {
                  wodindi.shift();
               }
            }
            else
            {
               avatarVO.fronthair.wodID = Constants_Avatarparts.FEMALE_FRONTHAIR_STARTWODID + int(wodindi.shift());
            }
            if(wodindi[0])
            {
               avatarVO.background.wodID = Constants_Avatarparts.BACKGROUND_STARTWODID + int(wodindi.shift());
            }
            avatarVO.shirtColor = Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(avatarVO.gender,avatarVO.body.wodID)[shirtColorIndex];
         }
         catch(e:Error)
         {
            trace("WRONG PIC STRING: " + sfString);
            avatarVO = createRandomAvatarVO();
         }
         return avatarVO;
      }
      
      public static function createRandomAvatarVO() : AvatarVO
      {
         return new AvatarVO(!!Random.boolean()?CharacterGender.Male:CharacterGender.Female,true);
      }
      
      public static function createSFStringFromAvatarVO(param1:AvatarVO) : String
      {
         var _loc2_:String = "!";
         var _loc3_:String = "~";
         var _loc4_:String = "";
         _loc4_ = _loc4_ + (param1.gender.index + _loc2_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.skinColor,Constants_Avatarparts.AVAILABLE_SKIN_COLORS) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.hairColor,Constants_Avatarparts.AVAILABLE_HAIR_COLORS) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.eyeColor,Constants_Avatarparts.AVAILABLE_EYE_COLORS) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.eyebrowColor,Constants_Avatarparts.AVAILABLE_HAIR_COLORS) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.shirtColor,Constants_Avatarparts.getAVAILABLE_SHIRT_COLORS(param1.gender,param1.body.wodID)) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.lipstickColor,Constants_Avatarparts.AVAILABLE_LIPSTICK_COLORS) + _loc3_);
         _loc4_ = _loc4_ + (getIndexFromColorArray(param1.extraTopColor,Constants_Avatarparts.AVAILABLE_EXTRASTOP_COLORS) + _loc3_);
         _loc4_ = _loc4_ + getIndexFromColorArray(param1.extraUnderColor,Constants_Avatarparts.AVAILABLE_EXTRASUNDER_COLORS);
         _loc4_ = _loc4_ + _loc2_;
         if(param1.gender == CharacterGender.Male)
         {
            _loc4_ = _loc4_ + (getMinWodiId(param1.backhair.wodID - Constants_Avatarparts.MALE_BACKHAIR_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.body.wodID - Constants_Avatarparts.MALE_BODY_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.jaw.wodID - Constants_Avatarparts.MALE_JAW_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.beard.wodID - Constants_Avatarparts.MALE_BEARD_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.extraUnder.wodID - Constants_Avatarparts.MALE_EXTRASUNDER_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.eyes.wodID - Constants_Avatarparts.MALE_EYES_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.eyebrows.wodID - Constants_Avatarparts.MALE_EYEBROWS_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.nose.wodID - Constants_Avatarparts.MALE_NOSES_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.mouth.wodID - Constants_Avatarparts.MALE_MOUTHS_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.extraTop.wodID - Constants_Avatarparts.MALE_EXTRASTOP_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.fronthair.wodID - Constants_Avatarparts.MALE_FRONTHAIR_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + getMinWodiId(param1.background.wodID - Constants_Avatarparts.BACKGROUND_STARTWODID);
         }
         else
         {
            _loc4_ = _loc4_ + (getMinWodiId(param1.backhair.wodID - Constants_Avatarparts.FEMALE_BACKHAIR_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.body.wodID - Constants_Avatarparts.FEMALE_BODY_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.jaw.wodID - Constants_Avatarparts.FEMALE_JAW_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.extraUnder.wodID - Constants_Avatarparts.FEMALE_EXTRASUNDER_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.eyes.wodID - Constants_Avatarparts.FEMALE_EYES_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.eyebrows.wodID - Constants_Avatarparts.FEMALE_EYEBROWS_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.nose.wodID - Constants_Avatarparts.FEMALE_NOSES_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.mouth.wodID - Constants_Avatarparts.FEMALE_MOUTHS_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.extraTop.wodID - Constants_Avatarparts.FEMALE_EXTRASTOP_STARTWODID + 1) + _loc3_);
            _loc4_ = _loc4_ + (getMinWodiId(param1.fronthair.wodID - Constants_Avatarparts.FEMALE_FRONTHAIR_STARTWODID) + _loc3_);
            _loc4_ = _loc4_ + getMinWodiId(param1.background.wodID - Constants_Avatarparts.BACKGROUND_STARTWODID);
         }
         return _loc4_;
      }
      
      private static function getMinWodiId(param1:int) : int
      {
         return Math.max(0,param1);
      }
      
      public static function getWodIdLists(param1:CharacterGender) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         _loc2_[Constants_Avatarparts.PART_JAWS] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_JAWS_AVAILABLE:Constants_Avatarparts.FEMALE_JAWS_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_JAWS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_JAW_STARTWODID:Constants_Avatarparts.MALE_JAW_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_BODYS] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_BODY_AVAILABLE:Constants_Avatarparts.MALE_BODY_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_BODYS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_BODY_STARTWODID:Constants_Avatarparts.MALE_BODY_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_EXTRASUNDER] = [];
         _loc2_[Constants_Avatarparts.PART_EXTRASUNDER].push(-1);
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EXTRASUNDER_AVAILABLE:Constants_Avatarparts.MALE_EXTRASUNDER_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_EXTRASUNDER].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EXTRASUNDER_STARTWODID:Constants_Avatarparts.MALE_EXTRASUNDER_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_EXTRASTOP] = [];
         _loc2_[Constants_Avatarparts.PART_EXTRASTOP].push(-1);
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EXTRASTOP_AVAILABLE:Constants_Avatarparts.MALE_EXTRASTOP_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_EXTRASTOP].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EXTRASTOP_STARTWODID:Constants_Avatarparts.MALE_EXTRASTOP_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_MOUTHS] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_MOUTHS_AVAILABLE:Constants_Avatarparts.MALE_MOUTHS_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_MOUTHS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_MOUTHS_STARTWODID:Constants_Avatarparts.MALE_MOUTHS_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_NOSES] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_NOSE_AVAILABLE:Constants_Avatarparts.MALE_NOSE_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_NOSES].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_NOSES_STARTWODID:Constants_Avatarparts.MALE_NOSES_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_EYES] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EYES_AVAILABLE:Constants_Avatarparts.MALE_EYES_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_EYES].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EYES_STARTWODID:Constants_Avatarparts.MALE_EYES_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_EYEBROWS] = [];
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EYEBROWS_AVAILABLE:Constants_Avatarparts.MALE_EYEBROWS_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_EYEBROWS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_EYEBROWS_STARTWODID:Constants_Avatarparts.MALE_EYEBROWS_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_FRONTHAIRS] = [];
         if(param1 == CharacterGender.Male)
         {
            _loc2_[Constants_Avatarparts.PART_FRONTHAIRS].push(-1);
         }
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_FRONTHAIRS_AVAILABLE:Constants_Avatarparts.MALE_FRONTHAIRS_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_FRONTHAIRS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_FRONTHAIR_STARTWODID:Constants_Avatarparts.MALE_FRONTHAIR_STARTWODID) + _loc3_);
            _loc3_++;
         }
         _loc2_[Constants_Avatarparts.PART_BACKHAIRS] = [];
         _loc2_[Constants_Avatarparts.PART_BACKHAIRS].push(-1);
         _loc3_ = 0;
         while(_loc3_ < (param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_BACKHAIRS_AVAILABLE:Constants_Avatarparts.MALE_BACKHAIRS_AVAILABLE))
         {
            _loc2_[Constants_Avatarparts.PART_BACKHAIRS].push((param1 == CharacterGender.Female?Constants_Avatarparts.FEMALE_BACKHAIR_STARTWODID:Constants_Avatarparts.MALE_BACKHAIR_STARTWODID) + _loc3_);
            _loc3_++;
         }
         if(param1 == CharacterGender.Male)
         {
            _loc2_[Constants_Avatarparts.PART_BEARDS] = [];
            _loc2_[Constants_Avatarparts.PART_BEARDS].push(-1);
            _loc3_ = 0;
            while(_loc3_ < Constants_Avatarparts.MALE_BEARDS_AVAILABLE)
            {
               _loc2_[Constants_Avatarparts.PART_BEARDS].push(Constants_Avatarparts.MALE_BEARD_STARTWODID + _loc3_);
               _loc3_++;
            }
         }
         _loc2_[Constants_Avatarparts.PART_BACKGROUNDS] = [];
         _loc3_ = 0;
         while(_loc3_ < Constants_Avatarparts.BACKGROUNDS_AVAILABLE)
         {
            _loc2_[Constants_Avatarparts.PART_BACKGROUNDS].push(Constants_Avatarparts.BACKGROUND_STARTWODID + _loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function getIndexFromColorArray(param1:Object, param2:Array) : int
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(param2.length == 0)
         {
            return 0;
         }
         if(param1 is Array)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               _loc4_ = param2[_loc3_];
               _loc5_ = true;
               _loc6_ = 0;
               while(_loc6_ < param1.length)
               {
                  if(param1[_loc6_] != _loc4_[_loc6_])
                  {
                     _loc5_ = false;
                  }
                  _loc6_++;
               }
               if(_loc5_)
               {
                  return _loc3_;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc7_ = 0;
            while(_loc7_ < param2.length)
            {
               if(param2[_loc7_] == param1)
               {
                  return _loc7_;
               }
               _loc7_++;
            }
         }
         return 0;
      }
      
      public static function getAvailableBeardsByJawWodId(param1:int) : Array
      {
         return BEARDS_ON_JAWS["jaw_" + param1];
      }
      
      private static function get BEARDS_ON_JAWS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_["jaw_19500"] = [-1,20500,20501,20503];
         _loc1_["jaw_19501"] = [-1,20504,20506];
         _loc1_["jaw_19502"] = [-1,20502,20505];
         return _loc1_;
      }
      
      public static function cloneAvatarVO(param1:AvatarVO) : AvatarVO
      {
         var _loc2_:AvatarVO = new AvatarVO(param1.gender);
         _loc2_.backhair.wodID = param1.backhair.wodID;
         if(param1.gender == CharacterGender.Male)
         {
            _loc2_.beard.wodID = param1.beard.wodID;
         }
         _loc2_.body.wodID = param1.body.wodID;
         _loc2_.characterClass = param1.characterClass;
         _loc2_.ears.wodID = param1.ears.wodID;
         _loc2_.extraTop.wodID = param1.extraTop.wodID;
         _loc2_.extraTopColor = param1.extraTopColor;
         _loc2_.extraUnder.wodID = param1.extraUnder.wodID;
         _loc2_.extraUnderColor = param1.extraUnderColor;
         _loc2_.eyebrowColor = param1.eyebrowColor;
         _loc2_.eyebrows.wodID = param1.eyebrows.wodID;
         _loc2_.eyeColor = param1.eyeColor;
         _loc2_.eyes.wodID = param1.eyes.wodID;
         _loc2_.face.wodID = param1.face.wodID;
         _loc2_.fronthair.wodID = param1.fronthair.wodID;
         _loc2_.hairColor = param1.hairColor;
         _loc2_.jaw.wodID = param1.jaw.wodID;
         _loc2_.lipstickColor = param1.lipstickColor;
         _loc2_.mouth.wodID = param1.mouth.wodID;
         _loc2_.nose.wodID = param1.nose.wodID;
         _loc2_.shirtColor = param1.shirtColor.concat();
         _loc2_.skinColor = param1.skinColor;
         _loc2_.background.wodID = param1.background.wodID;
         _loc2_.characterClass = param1.characterClass;
         return _loc2_;
      }
      
      public static function areEqual(param1:AvatarVO, param2:AvatarVO) : Boolean
      {
         if(param1.gender != param2.gender)
         {
            return false;
         }
         if(param1.gender == CharacterGender.Male && param1.beard.wodID != param2.beard.wodID)
         {
            return false;
         }
         if(param1.background.wodID != param2.background.wodID)
         {
            return false;
         }
         if(param1.backhair.wodID != param2.backhair.wodID)
         {
            return false;
         }
         if(param1.body.wodID != param2.body.wodID)
         {
            return false;
         }
         if(param1.ears.wodID != param2.ears.wodID)
         {
            return false;
         }
         if(param1.extraTop.wodID != param2.extraTop.wodID)
         {
            return false;
         }
         if(param1.extraUnder.wodID != param2.extraUnder.wodID)
         {
            return false;
         }
         if(param1.extraUnderColor != param2.extraUnderColor)
         {
            return false;
         }
         if(param1.eyebrowColor != param2.eyebrowColor)
         {
            return false;
         }
         if(param1.eyebrows.wodID != param2.eyebrows.wodID)
         {
            return false;
         }
         if(param1.eyeColor != param2.eyeColor)
         {
            return false;
         }
         if(param1.eyes.wodID != param2.eyes.wodID)
         {
            return false;
         }
         if(param1.face.wodID != param2.face.wodID)
         {
            return false;
         }
         if(param1.fronthair.wodID != param2.fronthair.wodID)
         {
            return false;
         }
         if(param1.hairColor != param2.hairColor)
         {
            return false;
         }
         if(param1.jaw.wodID != param2.jaw.wodID)
         {
            return false;
         }
         if(param1.lipstickColor != param2.lipstickColor)
         {
            return false;
         }
         if(param1.mouth.wodID != param2.mouth.wodID)
         {
            return false;
         }
         if(param1.nose.wodID != param2.nose.wodID)
         {
            return false;
         }
         if(param1.skinColor != param2.skinColor)
         {
            return false;
         }
         if(param1.shirtColor.length != param2.shirtColor.length)
         {
            return false;
         }
         if(param1.shirtColor[0] != param2.shirtColor[0])
         {
            return false;
         }
         if(param1.shirtColor[1] && param1.shirtColor[1] != param2.shirtColor[1])
         {
            return false;
         }
         return true;
      }
      
      public static function isLegalChar(param1:AvatarVO) : Boolean
      {
         if(param1.gender != CharacterGender.Male && param1.gender != CharacterGender.Female)
         {
            return false;
         }
         if(!isWodInTypeArray(param1.background.wodID,Constants_Avatarparts.PART_BACKGROUNDS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.jaw.wodID,Constants_Avatarparts.PART_JAWS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.body.wodID,Constants_Avatarparts.PART_BODYS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.extraUnder.wodID,Constants_Avatarparts.PART_EXTRASUNDER,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.extraTop.wodID,Constants_Avatarparts.PART_EXTRASTOP,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.mouth.wodID,Constants_Avatarparts.PART_MOUTHS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.nose.wodID,Constants_Avatarparts.PART_NOSES,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.eyes.wodID,Constants_Avatarparts.PART_EYES,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.eyebrows.wodID,Constants_Avatarparts.PART_EYEBROWS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.fronthair.wodID,Constants_Avatarparts.PART_FRONTHAIRS,param1.gender))
         {
            return false;
         }
         if(!isWodInTypeArray(param1.backhair.wodID,Constants_Avatarparts.PART_BACKHAIRS,param1.gender))
         {
            return false;
         }
         if(param1.gender == CharacterGender.Male)
         {
            if(!isWodInTypeArray(param1.beard.wodID,Constants_Avatarparts.PART_BEARDS,param1.gender))
            {
               return false;
            }
         }
         if(!isColorInColorArray(param1.skinColor,Constants_Avatarparts.AVAILABLE_SKIN_COLORS))
         {
            return false;
         }
         if(!isColorInColorArray(param1.hairColor,Constants_Avatarparts.AVAILABLE_HAIR_COLORS))
         {
            return false;
         }
         if(!isColorInColorArray(param1.eyebrowColor,Constants_Avatarparts.AVAILABLE_HAIR_COLORS))
         {
            return false;
         }
         if(param1.characterClass != CharacterClass.Bully && param1.characterClass != CharacterClass.Rogue && param1.characterClass != CharacterClass.Tactician)
         {
            return false;
         }
         return true;
      }
      
      private static function isColorInColorArray(param1:uint, param2:Array) : Boolean
      {
         var _loc3_:uint = 0;
         for each(_loc3_ in param2)
         {
            if(_loc3_ == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function isWodInTypeArray(param1:int, param2:String, param3:CharacterGender) : Boolean
      {
         var _loc4_:Array = getWodIdLists(param3);
         if(!_loc4_[param2])
         {
            return false;
         }
         _loc4_ = _loc4_[param2];
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] == param1)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public static function getCompleteAssetStringList() : Vector.<String>
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:Vector.<String> = new Vector.<String>();
         _loc1_.push(env.getAvatarSwfUrlByWodId(21000));
         _loc1_.push(env.getAvatarSwfUrlByWodId(21001));
         _loc1_.push(env.getAvatarSwfUrlByWodId(21002));
         _loc1_.push(env.getAvatarSwfUrlByWodId(21003));
         for each(_loc2_ in getWodIdLists(CharacterGender.Male))
         {
            for each(_loc4_ in _loc2_)
            {
               if(_loc4_ != -1)
               {
                  _loc1_.push(env.getAvatarSwfUrlByWodId(_loc4_));
               }
            }
         }
         for each(_loc3_ in getWodIdLists(CharacterGender.Female))
         {
            for each(_loc5_ in _loc3_)
            {
               if(_loc5_ != -1)
               {
                  _loc1_.push(env.getAvatarSwfUrlByWodId(_loc5_));
               }
            }
         }
         return _loc1_;
      }
      
      private static function get env() : MafiaEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
      
      public static function createAvatarByPicID(param1:int) : Sprite
      {
         var oClass:Class = null;
         var picId:int = param1;
         try
         {
            oClass = getDefinitionByName("Enemy" + picId) as Class;
            return new oClass();
         }
         catch(e:Error)
         {
            trace("WRONG PIC ID: " + picId + " (ok for hk gangwar enemies)");
         }
         return new Sprite();
      }
   }
}
