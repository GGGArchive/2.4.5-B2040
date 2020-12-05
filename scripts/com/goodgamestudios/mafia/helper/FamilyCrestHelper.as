package com.goodgamestudios.mafia.helper
{
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestPartVO;
   import com.goodgamestudios.mafia.vo.clan.FamilyCrestVO;
   import com.goodgamestudios.math.Random;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.utils.getDefinitionByName;
   
   public class FamilyCrestHelper
   {
      
      private static const NUM_PARTS_PRIMARY:int = 17;
      
      private static const NUM_PARTS_SECONDARY:int = 13;
      
      private static const NUM_PARTS_BANDEROLES:int = 6;
      
      private static const PART_CATEGORY_PRIMARY:int = 3;
      
      private static const PART_CATEGORY_SECONDARY:int = 2;
      
      private static const PART_CATEGORY_BANDEROLE:int = 1;
       
      
      public function FamilyCrestHelper()
      {
         super();
      }
      
      public static function createFamilyCrest(param1:FamilyCrestVO, param2:String, param3:Boolean = false) : Sprite
      {
         var _loc4_:Sprite = new Sprite();
         if(param1 == null)
         {
            return _loc4_;
         }
         addPart(_loc4_,param1.secondary);
         addPart(_loc4_,param1.primary);
         if(!param3)
         {
            addPart(_loc4_,param1.banderole,param2);
         }
         _loc4_.mouseChildren = false;
         return _loc4_;
      }
      
      private static function createPart(param1:int, param2:int, param3:int = 1) : MovieClip
      {
         var _loc4_:String = param2.toString();
         while(_loc4_.length < 2)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:String = param3.toString();
         while(_loc5_.length < 2)
         {
            _loc5_ = "0" + _loc5_;
         }
         return new (getDefinitionByName("FamilyCrestPart_" + param1 + "_" + _loc4_ + "_" + _loc5_) as Class)() as MovieClip;
      }
      
      private static function colorizePart(param1:MovieClip, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:Array = getColorsForPart(param2,param3,param4);
         var _loc7_:Object = _loc6_[param5];
         if(_loc7_ is Array)
         {
            _loc8_ = _loc7_ as Array;
            _loc9_ = _loc8_[0];
            _loc10_ = 0;
            _loc11_ = 0;
            if(_loc8_.length > 1)
            {
               _loc10_ = _loc8_[1];
               if(_loc8_.length > 2)
               {
                  _loc11_ = _loc8_[2];
               }
            }
            colorizeColorElements(param1,_loc9_,_loc10_,_loc11_);
         }
         else
         {
            colorizeColorElements(param1,_loc7_ as uint);
         }
      }
      
      private static function addPart(param1:Sprite, param2:FamilyCrestPartVO, param3:String = "") : void
      {
         var _loc5_:FamilyCrestPartLoader = null;
         var _loc4_:MovieClip = new MovieClip();
         if(isPartLoaded(param2.category,param2.type,param2.variation))
         {
            addPartToPartContainer(param2,_loc4_,param3);
         }
         else
         {
            _loc5_ = SWFLoaderHelper.instance.loadFamilyCrestPartSWF(env.getFamilyCrestPartSwfUrl(param2.category,param2.type,param2.variation),onCompleteLoading) as FamilyCrestPartLoader;
            _loc5_.partVO = param2;
            _loc5_.banderoleText = param3;
            _loc4_.addChild(_loc5_);
         }
         param1.addChild(_loc4_);
      }
      
      private static function addPartToPartContainer(param1:FamilyCrestPartVO, param2:DisplayObjectContainer, param3:String = "") : void
      {
         var _loc5_:MovieClip = null;
         var _loc6_:TextField = null;
         var _loc4_:MovieClip = createPart(param1.category,param1.type,param1.variation);
         if(param3 != "" && _loc4_.txt_pos != null)
         {
            _loc5_ = new BanderoleTextfield();
            _loc5_.gotoAndStop(param1.type == 3?2:1);
            _loc4_.txt_pos.addChild(_loc5_);
            _loc6_ = _loc5_.txt as TextField;
            _loc6_.text = param3;
            if(_loc6_.textWidth == 0)
            {
               _loc6_.embedFonts = false;
               _loc6_.text = param3;
            }
         }
         colorizePart(_loc4_ as MovieClip,param1.category,param1.type,param1.variation,param1.color);
         param2.addChild(_loc4_);
      }
      
      private static function onCompleteLoading(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:FamilyCrestPartLoader = _loc2_.loader as FamilyCrestPartLoader;
         var _loc4_:DisplayObjectContainer = _loc3_.parent;
         _loc4_.removeChild(_loc3_);
         var _loc5_:FamilyCrestPartVO = _loc3_.partVO;
         var _loc6_:String = _loc3_.banderoleText;
         addPartToPartContainer(_loc5_,_loc4_,_loc6_);
      }
      
      public static function getAvailableColorsOfPart(param1:FamilyCrestPartVO) : Array
      {
         var _loc2_:Array = getColorsForPart(param1.category,param1.type,param1.variation);
         return _loc2_;
      }
      
      public static function getSelectedColorsOfPart(param1:FamilyCrestPartVO) : Object
      {
         var _loc2_:Array = getColorsForPart(param1.category,param1.type,param1.variation);
         var _loc3_:Object = _loc2_[param1.color];
         return _loc3_;
      }
      
      private static function colorizeColorElements(param1:MovieClip, param2:uint = 0, param3:uint = 0, param4:uint = 0) : void
      {
         if(!param1.color_0)
         {
            return;
         }
         var _loc5_:ColorTransform = new ColorTransform();
         _loc5_.color = param2;
         param1.color_0.transform.colorTransform = _loc5_;
         if(!param1.color_1)
         {
            return;
         }
         _loc5_.color = param3;
         param1.color_1.transform.colorTransform = _loc5_;
         if(!param1.color_2)
         {
            return;
         }
         _loc5_.color = param4;
         param1.color_2.transform.colorTransform = _loc5_;
      }
      
      private static function getColorsForPart(param1:int, param2:int, param3:int = 1) : Array
      {
         loop0:
         switch(param1)
         {
            case PART_CATEGORY_PRIMARY:
               switch(param2)
               {
                  case 1:
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                  case 14:
                     return [15456951,11575428,16770609,16238398,16751687,16742429,15356484,11365646,10079283];
                  case 9:
                     return [15456951,8023654,16770609,16238398,16751687,16742429,13185830,877946,9858767];
                  case 15:
                     return [[15456951,16742429],[16238398,13185830],[16318443,2463152],[11575428,16772989],[12110991,15356484],[16770609,2463152],[16751687,14476999],[15356484,15456951],[16770609,8023654]];
                  case 16:
                     return [16742429,15356484,12233935,2463152,10079283,11365646,15456951,13185830,16770609];
                  case 17:
                     return [[2463152,13185830],[13185830,16772989],[9858767,10079283],[15456951,2463152],[16742429,877946],[10079283,15356484],[16770609,9858767],[9858767,15366768],[11575428,16244114]];
                  default:
                     break loop0;
               }
            case PART_CATEGORY_SECONDARY:
               switch(param2)
               {
                  case 1:
                     return [[16318443,12233935],[16772989,2463152],[16770609,16746839],[15356484,16318443],[16746839,13185830],[16742429,16772989],[16758405,16742429],[12233935,2463152],[2463152,12110991]];
                  case 2:
                  case 3:
                  case 4:
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                  case 9:
                  case 10:
                  case 11:
                  case 12:
                  case 13:
                     return [14079702,13944758,16772989,16244114,16758405,16746839,15366768,11372624,12110991];
                  default:
                     break loop0;
               }
            case PART_CATEGORY_BANDEROLE:
               switch(param2)
               {
                  case 4:
                  case 5:
                     return [[16318443,16244114],[15456951,11372624],[12695970,15356484],[11573101,12110991],[9269854,16751687],[8024170,2463152],[12233935,16746839]];
                  default:
                     return [16318443,15456951,12695970,11573101,9269854,8024170,12233935];
               }
         }
         return [0];
      }
      
      public static function getCompleteAssetStringList() : Vector.<String>
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:Array = [1,1,1,1,1,1,1,1,2,5,1,3,5,5,2,1,1];
         var _loc2_:Vector.<String> = new Vector.<String>();
         var _loc3_:int = 1;
         while(_loc3_ <= NUM_PARTS_PRIMARY)
         {
            _loc6_ = _loc1_[_loc3_ - 1];
            _loc7_ = 1;
            while(_loc7_ <= _loc6_)
            {
               _loc2_.push(env.getFamilyCrestPartSwfUrl(PART_CATEGORY_PRIMARY,_loc3_,_loc7_));
               _loc7_++;
            }
            _loc3_++;
         }
         var _loc4_:int = 1;
         while(_loc4_ <= NUM_PARTS_SECONDARY)
         {
            _loc2_.push(env.getFamilyCrestPartSwfUrl(PART_CATEGORY_SECONDARY,_loc4_,1));
            _loc4_++;
         }
         var _loc5_:int = 1;
         while(_loc5_ <= NUM_PARTS_BANDEROLES)
         {
            _loc2_.push(env.getFamilyCrestPartSwfUrl(PART_CATEGORY_BANDEROLE,_loc5_,1));
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function getNextAvailablePart(param1:FamilyCrestPartVO, param2:Vector.<FamilyCrestPartVO>) : FamilyCrestPartVO
      {
         var _loc5_:FamilyCrestPartVO = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc3_.category = param1.category;
         var _loc4_:int = int.MAX_VALUE;
         for each(_loc5_ in param2)
         {
            if(_loc5_.type > param1.type && _loc5_.type < _loc4_)
            {
               _loc4_ = _loc5_.type;
               if(_loc4_ == param1.type + 1)
               {
                  break;
               }
            }
         }
         if(_loc4_ < int.MAX_VALUE)
         {
            _loc3_.type = _loc4_;
         }
         else
         {
            _loc6_ = param1.type;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type < _loc6_)
               {
                  _loc6_ = _loc5_.type;
               }
            }
            _loc3_.type = _loc6_;
         }
         if(_loc3_.type == param1.type)
         {
            _loc3_.variation = param1.variation;
         }
         else
         {
            _loc7_ = int.MAX_VALUE;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type == _loc3_.type && _loc5_.variation < _loc7_)
               {
                  _loc7_ = _loc5_.variation;
               }
            }
            _loc3_.variation = _loc7_;
         }
         _loc3_.costGold = getCostOfPart(_loc3_.category,_loc3_.type,_loc3_.variation);
         giveRandomColorToPart(_loc3_);
         return _loc3_;
      }
      
      private static function giveRandomColorToPart(param1:FamilyCrestPartVO) : void
      {
         var _loc2_:Array = getAvailableColorsOfPart(param1);
         param1.color = Random.integer(_loc2_.length);
      }
      
      public static function getPrevAvailablePart(param1:FamilyCrestPartVO, param2:Vector.<FamilyCrestPartVO>) : FamilyCrestPartVO
      {
         var _loc5_:FamilyCrestPartVO = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc3_.category = param1.category;
         var _loc4_:int = 0;
         for each(_loc5_ in param2)
         {
            if(_loc5_.type < param1.type && _loc5_.type > _loc4_)
            {
               _loc4_ = _loc5_.type;
               if(_loc4_ == param1.type - 1)
               {
                  break;
               }
            }
         }
         if(_loc4_ > 0)
         {
            _loc3_.type = _loc4_;
         }
         else
         {
            _loc6_ = param1.type;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type > _loc6_)
               {
                  _loc6_ = _loc5_.type;
               }
            }
            _loc3_.type = _loc6_;
         }
         if(_loc3_.type == param1.type)
         {
            _loc3_.variation = param1.variation;
         }
         else
         {
            _loc7_ = int.MAX_VALUE;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type == _loc3_.type && _loc5_.variation < _loc7_)
               {
                  _loc7_ = _loc5_.variation;
               }
            }
            _loc3_.variation = _loc7_;
         }
         _loc3_.costGold = getCostOfPart(_loc3_.category,_loc3_.type,_loc3_.variation);
         giveRandomColorToPart(_loc3_);
         return _loc3_;
      }
      
      public static function doesPartHaveVariations(param1:FamilyCrestPartVO, param2:Vector.<FamilyCrestPartVO>) : Boolean
      {
         var _loc4_:FamilyCrestPartVO = null;
         var _loc3_:uint = 0;
         for each(_loc4_ in param2)
         {
            if(_loc4_.category == param1.category && _loc4_.type == param1.type)
            {
               _loc3_++;
               if(_loc3_ > 1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public static function getNextAvailableVariationForPart(param1:FamilyCrestPartVO, param2:Vector.<FamilyCrestPartVO>) : FamilyCrestPartVO
      {
         var _loc5_:FamilyCrestPartVO = null;
         var _loc6_:int = 0;
         var _loc3_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc3_.category = param1.category;
         _loc3_.type = param1.type;
         var _loc4_:int = int.MAX_VALUE;
         for each(_loc5_ in param2)
         {
            if(_loc5_.type == _loc3_.type && _loc5_.variation > param1.variation && _loc5_.variation < _loc4_)
            {
               _loc4_ = _loc5_.variation;
               if(_loc4_ == param1.variation + 1)
               {
                  break;
               }
            }
         }
         if(_loc4_ < int.MAX_VALUE)
         {
            _loc3_.variation = _loc4_;
         }
         else
         {
            _loc6_ = int.MAX_VALUE;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type == _loc3_.type && _loc5_.variation < _loc6_)
               {
                  _loc6_ = _loc5_.variation;
               }
            }
            _loc3_.variation = _loc6_;
         }
         _loc3_.costGold = getCostOfPart(_loc3_.category,_loc3_.type,_loc3_.variation);
         giveRandomColorToPart(_loc3_);
         return _loc3_;
      }
      
      public static function getPrevAvailableVariationForPart(param1:FamilyCrestPartVO, param2:Vector.<FamilyCrestPartVO>) : FamilyCrestPartVO
      {
         var _loc5_:FamilyCrestPartVO = null;
         var _loc6_:int = 0;
         var _loc3_:FamilyCrestPartVO = new FamilyCrestPartVO();
         _loc3_.category = param1.category;
         _loc3_.type = param1.type;
         var _loc4_:int = 0;
         for each(_loc5_ in param2)
         {
            if(_loc5_.type == _loc3_.type && _loc5_.variation < param1.variation && _loc5_.variation > _loc4_)
            {
               _loc4_ = _loc5_.variation;
               if(_loc4_ == param1.variation - 1)
               {
                  break;
               }
            }
         }
         if(_loc4_ > 0)
         {
            _loc3_.variation = _loc4_;
         }
         else
         {
            _loc6_ = 0;
            for each(_loc5_ in param2)
            {
               if(_loc5_.type == _loc3_.type && _loc5_.variation > _loc6_)
               {
                  _loc6_ = _loc5_.variation;
               }
            }
            _loc3_.variation = _loc6_;
         }
         _loc3_.costGold = getCostOfPart(_loc3_.category,_loc3_.type,_loc3_.variation);
         giveRandomColorToPart(_loc3_);
         return _loc3_;
      }
      
      public static function getRandomCrest() : FamilyCrestVO
      {
         var _loc1_:FamilyCrestVO = new FamilyCrestVO();
         var _loc2_:Vector.<FamilyCrestPartVO> = MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts;
         var _loc3_:Vector.<FamilyCrestPartVO> = MafiaModel.userData.userClan.availableFamilyCrestSecondaryParts;
         var _loc4_:Vector.<FamilyCrestPartVO> = MafiaModel.userData.userClan.availableFamilyCrestBanderoleParts;
         var _loc5_:int = getRandomPartTypeFromList(_loc2_);
         _loc1_.primary = getRandomPartVariationOfTypeFromList(_loc5_,_loc2_).copy();
         giveRandomColorToPart(_loc1_.primary);
         var _loc6_:int = getRandomPartTypeFromList(_loc3_);
         _loc1_.secondary = getRandomPartVariationOfTypeFromList(_loc6_,_loc3_).copy();
         giveRandomColorToPart(_loc1_.secondary);
         var _loc7_:int = getRandomPartTypeFromList(_loc4_);
         _loc1_.banderole = getRandomPartVariationOfTypeFromList(_loc7_,_loc4_).copy();
         giveRandomColorToPart(_loc1_.banderole);
         return _loc1_;
      }
      
      public static function arePartsIdentical(param1:FamilyCrestPartVO, param2:FamilyCrestPartVO) : Boolean
      {
         return param1.category == param2.category && param1.type == param2.type && param1.variation == param2.variation && param1.color == param2.color;
      }
      
      private static function getAvailablePartByValues(param1:int, param2:int, param3:int) : FamilyCrestPartVO
      {
         var _loc4_:FamilyCrestPartVO = null;
         switch(param1)
         {
            case PART_CATEGORY_PRIMARY:
               for each(_loc4_ in MafiaModel.userData.userClan.availableFamilyCrestPrimaryParts)
               {
                  if(_loc4_.type == param2 && _loc4_.variation == param3)
                  {
                     return _loc4_;
                  }
               }
               break;
            case PART_CATEGORY_SECONDARY:
               for each(_loc4_ in MafiaModel.userData.userClan.availableFamilyCrestSecondaryParts)
               {
                  if(_loc4_.type == param2 && _loc4_.variation == param3)
                  {
                     return _loc4_;
                  }
               }
               break;
            case PART_CATEGORY_BANDEROLE:
               for each(_loc4_ in MafiaModel.userData.userClan.availableFamilyCrestBanderoleParts)
               {
                  if(_loc4_.type == param2 && _loc4_.variation == param3)
                  {
                     return _loc4_;
                  }
               }
         }
         return null;
      }
      
      private static function getCostOfPart(param1:int, param2:int, param3:int) : uint
      {
         var _loc4_:uint = 0;
         var _loc5_:FamilyCrestPartVO = getAvailablePartByValues(param1,param2,param3);
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.costGold;
         }
         return _loc4_;
      }
      
      private static function getRandomPartTypeFromList(param1:Vector.<FamilyCrestPartVO>) : int
      {
         var _loc3_:FamilyCrestPartVO = null;
         var _loc2_:Vector.<int> = new Vector.<int>();
         for each(_loc3_ in param1)
         {
            if(_loc2_.indexOf(_loc3_.type) == -1)
            {
               _loc2_.push(_loc3_.type);
            }
         }
         return _loc2_[Random.integer(_loc2_.length)];
      }
      
      private static function getRandomPartVariationOfTypeFromList(param1:int, param2:Vector.<FamilyCrestPartVO>) : FamilyCrestPartVO
      {
         var _loc4_:FamilyCrestPartVO = null;
         var _loc3_:Vector.<FamilyCrestPartVO> = new Vector.<FamilyCrestPartVO>();
         for each(_loc4_ in param2)
         {
            if(_loc4_.type == param1)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_[Random.integer(_loc3_.length)];
      }
      
      private static function isPartLoaded(param1:int, param2:int, param3:int = 1) : Boolean
      {
         return SWFLoaderHelper.instance.isSWFLoaded(env.getFamilyCrestPartSwfUrl(param1,param2,param3));
      }
      
      private static function get env() : MafiaEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
