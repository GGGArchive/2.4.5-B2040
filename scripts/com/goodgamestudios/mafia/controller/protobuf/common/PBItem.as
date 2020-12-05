package com.goodgamestudios.mafia.controller.protobuf.common
{
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemEffect;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemQuality;
   import com.goodgamestudios.mafia.controller.protobuf.common.item.PBItemType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_BOOL;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.RepeatedFieldDescriptor$TYPE_MESSAGE;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBItem extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.id","id",1 << 3 | WireType.VARINT);
      
      public static const QUALITY:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.Item.quality","quality",2 << 3 | WireType.VARINT,PBItemQuality);
      
      public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.Item.type","type",3 << 3 | WireType.VARINT,PBItemType);
      
      public static const COSTS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.costs","costs",4 << 3 | WireType.LENGTH_DELIMITED,PBCosts);
      
      public static const ISGOLDPRICE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.goodgamestudios.mafia.controller.protobuf.common.Item.isGoldPrice","isGoldPrice",5 << 3 | WireType.VARINT);
      
      public static const LEVELS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.levels","levels",6 << 3 | WireType.LENGTH_DELIMITED,PBLevels);
      
      public static const SUB_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.sub_type","subType",7 << 3 | WireType.VARINT);
      
      public static const ATTRIBUTES:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.attributes","attributes",8 << 3 | WireType.LENGTH_DELIMITED,PBAttributes);
      
      public static const DAMAGE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.damage","damage",9 << 3 | WireType.LENGTH_DELIMITED,PBDamage);
      
      public static const SHAPE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.shape","shape",10 << 3 | WireType.LENGTH_DELIMITED,PBShape);
      
      public static const DURATION:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.duration","duration",11 << 3 | WireType.LENGTH_DELIMITED,PBDuration);
      
      public static const AMOUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.amount","amount",12 << 3 | WireType.VARINT);
      
      public static const ROUNDS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.rounds","rounds",13 << 3 | WireType.VARINT);
      
      public static const EFFECTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.common.Item.effects","effects",14 << 3 | WireType.LENGTH_DELIMITED,PBItemEffect);
      
      public static const DEPENDENCIES:RepeatedFieldDescriptor$TYPE_ENUM = new RepeatedFieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.common.Item.dependencies","dependencies",15 << 3 | WireType.VARINT,PBWeaponType);
      
      public static const CHARGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.common.Item.charge","charge",16 << 3 | WireType.VARINT);
       
      
      public var id:uint = 0;
      
      public var quality:int = 1;
      
      public var type:int;
      
      public var costs:PBCosts;
      
      public var isGoldPrice:Boolean;
      
      public var levels:PBLevels;
      
      private var sub_type$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var attributes$field:PBAttributes;
      
      private var damage$field:PBDamage;
      
      private var shape$field:PBShape;
      
      private var duration$field:PBDuration;
      
      private var amount$field:uint;
      
      private var rounds$field:uint;
      
      public var effects:Array;
      
      public var dependencies:Array;
      
      private var charge$field:uint;
      
      public function PBItem()
      {
         this.effects = [];
         this.dependencies = [];
         super();
      }
      
      public function clearSubType() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967294;
         this.sub_type$field = new uint();
      }
      
      public function get hasSubType() : Boolean
      {
         return (this.hasField$0 & 1) != 0;
      }
      
      public function set subType(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 1;
         this.sub_type$field = param1;
      }
      
      public function get subType() : uint
      {
         if(!this.hasSubType)
         {
            return 0;
         }
         return this.sub_type$field;
      }
      
      public function clearAttributes() : void
      {
         this.attributes$field = null;
      }
      
      public function get hasAttributes() : Boolean
      {
         return this.attributes$field != null;
      }
      
      public function set attributes(param1:PBAttributes) : void
      {
         this.attributes$field = param1;
      }
      
      public function get attributes() : PBAttributes
      {
         return this.attributes$field;
      }
      
      public function clearDamage() : void
      {
         this.damage$field = null;
      }
      
      public function get hasDamage() : Boolean
      {
         return this.damage$field != null;
      }
      
      public function set damage(param1:PBDamage) : void
      {
         this.damage$field = param1;
      }
      
      public function get damage() : PBDamage
      {
         return this.damage$field;
      }
      
      public function clearShape() : void
      {
         this.shape$field = null;
      }
      
      public function get hasShape() : Boolean
      {
         return this.shape$field != null;
      }
      
      public function set shape(param1:PBShape) : void
      {
         this.shape$field = param1;
      }
      
      public function get shape() : PBShape
      {
         return this.shape$field;
      }
      
      public function clearDuration() : void
      {
         this.duration$field = null;
      }
      
      public function get hasDuration() : Boolean
      {
         return this.duration$field != null;
      }
      
      public function set duration(param1:PBDuration) : void
      {
         this.duration$field = param1;
      }
      
      public function get duration() : PBDuration
      {
         return this.duration$field;
      }
      
      public function clearAmount() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967293;
         this.amount$field = new uint();
      }
      
      public function get hasAmount() : Boolean
      {
         return (this.hasField$0 & 2) != 0;
      }
      
      public function set amount(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 2;
         this.amount$field = param1;
      }
      
      public function get amount() : uint
      {
         if(!this.hasAmount)
         {
            return 1;
         }
         return this.amount$field;
      }
      
      public function clearRounds() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967291;
         this.rounds$field = new uint();
      }
      
      public function get hasRounds() : Boolean
      {
         return (this.hasField$0 & 4) != 0;
      }
      
      public function set rounds(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 4;
         this.rounds$field = param1;
      }
      
      public function get rounds() : uint
      {
         if(!this.hasRounds)
         {
            return 0;
         }
         return this.rounds$field;
      }
      
      public function clearCharge() : void
      {
         this.hasField$0 = this.hasField$0 & 4294967287;
         this.charge$field = new uint();
      }
      
      public function get hasCharge() : Boolean
      {
         return (this.hasField$0 & 8) != 0;
      }
      
      public function set charge(param1:uint) : void
      {
         this.hasField$0 = this.hasField$0 | 8;
         this.charge$field = param1;
      }
      
      public function get charge() : uint
      {
         return this.charge$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc4_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.quality);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.type);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
         WriteUtils.write$TYPE_MESSAGE(param1,this.costs);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_BOOL(param1,this.isGoldPrice);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
         WriteUtils.write$TYPE_MESSAGE(param1,this.levels);
         if(this.hasSubType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,this.sub_type$field);
         }
         if(this.hasAttributes)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
            WriteUtils.write$TYPE_MESSAGE(param1,this.attributes$field);
         }
         if(this.hasDamage)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
            WriteUtils.write$TYPE_MESSAGE(param1,this.damage$field);
         }
         if(this.hasShape)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_MESSAGE(param1,this.shape$field);
         }
         if(this.hasDuration)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,11);
            WriteUtils.write$TYPE_MESSAGE(param1,this.duration$field);
         }
         if(this.hasAmount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,12);
            WriteUtils.write$TYPE_UINT32(param1,this.amount$field);
         }
         if(this.hasRounds)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,13);
            WriteUtils.write$TYPE_UINT32(param1,this.rounds$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this.effects.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,14);
            WriteUtils.write$TYPE_MESSAGE(param1,this.effects[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this.dependencies.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,15);
            WriteUtils.write$TYPE_ENUM(param1,this.dependencies[_loc3_]);
            _loc3_++;
         }
         if(this.hasCharge)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,16);
            WriteUtils.write$TYPE_UINT32(param1,this.charge$field);
         }
         for(_loc4_ in this)
         {
            super.writeUnknown(param1,_loc4_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc17_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc17_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Item.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Item.quality cannot be set twice.");
                  }
                  _loc4_++;
                  this.quality = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Item.type cannot be set twice.");
                  }
                  _loc5_++;
                  this.type = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Item.costs cannot be set twice.");
                  }
                  _loc6_++;
                  this.costs = new PBCosts();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.costs);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Item.isGoldPrice cannot be set twice.");
                  }
                  _loc7_++;
                  this.isGoldPrice = ReadUtils.read$TYPE_BOOL(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Item.levels cannot be set twice.");
                  }
                  _loc8_++;
                  this.levels = new PBLevels();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.levels);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Item.subType cannot be set twice.");
                  }
                  _loc9_++;
                  this.subType = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Item.attributes cannot be set twice.");
                  }
                  _loc10_++;
                  this.attributes = new PBAttributes();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.attributes);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Item.damage cannot be set twice.");
                  }
                  _loc11_++;
                  this.damage = new PBDamage();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.damage);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: Item.shape cannot be set twice.");
                  }
                  _loc12_++;
                  this.shape = new PBShape();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.shape);
                  continue;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: Item.duration cannot be set twice.");
                  }
                  _loc13_++;
                  this.duration = new PBDuration();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.duration);
                  continue;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: Item.amount cannot be set twice.");
                  }
                  _loc14_++;
                  this.amount = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: Item.rounds cannot be set twice.");
                  }
                  _loc15_++;
                  this.rounds = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 14:
                  this.effects.push(ReadUtils.read$TYPE_MESSAGE(param1,new PBItemEffect()));
                  continue;
               case 15:
                  if((_loc17_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_ENUM,this.dependencies);
                  }
                  else
                  {
                     this.dependencies.push(ReadUtils.read$TYPE_ENUM(param1));
                  }
                  continue;
               case 16:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: Item.charge cannot be set twice.");
                  }
                  _loc16_++;
                  this.charge = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc17_);
                  continue;
            }
         }
      }
   }
}
