package com.goodgamestudios.mafia.controller.protobuf.fight
{
   import com.goodgamestudios.mafia.controller.protobuf.common.PBAttributes;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBCharacterClass;
   import com.goodgamestudios.mafia.controller.protobuf.common.PBGender;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fighter.PBFighterType;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WireType;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_ENUM;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_MESSAGE;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_STRING;
   import com.netease.protobuf.fieldDescriptors.FieldDescriptor$TYPE_UINT32;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   
   public final class PBFighter extends Message
   {
      
      public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.id","id",1 << 3 | WireType.VARINT);
      
      public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.type","type",2 << 3 | WireType.VARINT,PBFighterType);
      
      public static const GENDER:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.gender","gender",3 << 3 | WireType.VARINT,PBGender);
      
      public static const CHARACTER_CLASS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.character_class","characterClass",4 << 3 | WireType.VARINT,PBCharacterClass);
      
      public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.level","level",5 << 3 | WireType.VARINT);
      
      public static const TOTAL_HP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.total_hp","totalHp",6 << 3 | WireType.VARINT);
      
      public static const CURRENT_HP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.current_hp","currentHp",7 << 3 | WireType.VARINT);
      
      public static const ATTRIBUTES:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.attributes","attributes",8 << 3 | WireType.LENGTH_DELIMITED,PBAttributes);
      
      public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.name","name",9 << 3 | WireType.LENGTH_DELIMITED);
      
      public static const PIC_STRING:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.goodgamestudios.mafia.controller.protobuf.fight.Fighter.pic_string","picString",10 << 3 | WireType.LENGTH_DELIMITED);
       
      
      public var id:uint;
      
      public var type:int;
      
      public var gender:int;
      
      public var characterClass:int;
      
      public var level:uint;
      
      public var totalHp:uint;
      
      public var currentHp:uint;
      
      public var attributes:PBAttributes;
      
      private var name$field:String;
      
      private var pic_string$field:String;
      
      public function PBFighter()
      {
         super();
      }
      
      public function clearName() : void
      {
         this.name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return this.name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         this.name$field = param1;
      }
      
      public function get name() : String
      {
         return this.name$field;
      }
      
      public function clearPicString() : void
      {
         this.pic_string$field = null;
      }
      
      public function get hasPicString() : Boolean
      {
         return this.pic_string$field != null;
      }
      
      public function set picString(param1:String) : void
      {
         this.pic_string$field = param1;
      }
      
      public function get picString() : String
      {
         return this.pic_string$field;
      }
      
      override final function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = undefined;
         WriteUtils.writeTag(param1,WireType.VARINT,1);
         WriteUtils.write$TYPE_UINT32(param1,this.id);
         WriteUtils.writeTag(param1,WireType.VARINT,2);
         WriteUtils.write$TYPE_ENUM(param1,this.type);
         WriteUtils.writeTag(param1,WireType.VARINT,3);
         WriteUtils.write$TYPE_ENUM(param1,this.gender);
         WriteUtils.writeTag(param1,WireType.VARINT,4);
         WriteUtils.write$TYPE_ENUM(param1,this.characterClass);
         WriteUtils.writeTag(param1,WireType.VARINT,5);
         WriteUtils.write$TYPE_UINT32(param1,this.level);
         WriteUtils.writeTag(param1,WireType.VARINT,6);
         WriteUtils.write$TYPE_UINT32(param1,this.totalHp);
         WriteUtils.writeTag(param1,WireType.VARINT,7);
         WriteUtils.write$TYPE_UINT32(param1,this.currentHp);
         WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
         WriteUtils.write$TYPE_MESSAGE(param1,this.attributes);
         if(this.hasName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,9);
            WriteUtils.write$TYPE_STRING(param1,this.name$field);
         }
         if(this.hasPicString)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_STRING(param1,this.pic_string$field);
         }
         for(_loc2_ in this)
         {
            super.writeUnknown(param1,_loc2_);
         }
      }
      
      override final function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:uint = 0;
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
         while(param1.bytesAvailable > param2)
         {
            _loc13_ = ReadUtils.read$TYPE_UINT32(param1);
            switch(_loc13_ >> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.id cannot be set twice.");
                  }
                  _loc3_++;
                  this.id = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.type cannot be set twice.");
                  }
                  _loc4_++;
                  this.type = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.gender cannot be set twice.");
                  }
                  _loc5_++;
                  this.gender = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.characterClass cannot be set twice.");
                  }
                  _loc6_++;
                  this.characterClass = ReadUtils.read$TYPE_ENUM(param1);
                  continue;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.level cannot be set twice.");
                  }
                  _loc7_++;
                  this.level = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.totalHp cannot be set twice.");
                  }
                  _loc8_++;
                  this.totalHp = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.currentHp cannot be set twice.");
                  }
                  _loc9_++;
                  this.currentHp = ReadUtils.read$TYPE_UINT32(param1);
                  continue;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.attributes cannot be set twice.");
                  }
                  _loc10_++;
                  this.attributes = new PBAttributes();
                  ReadUtils.read$TYPE_MESSAGE(param1,this.attributes);
                  continue;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.name cannot be set twice.");
                  }
                  _loc11_++;
                  this.name = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: Fighter.picString cannot be set twice.");
                  }
                  _loc12_++;
                  this.picString = ReadUtils.read$TYPE_STRING(param1);
                  continue;
               default:
                  super.readUnknown(param1,_loc13_);
                  continue;
            }
         }
      }
   }
}
