package com.goodgamestudios.language.countries
{
   import com.goodgamestudios.language.unicodeRanges.UnicodeRange;
   import com.goodgamestudios.language.unicodeRanges.UnicodeRegistry;
   
   public class CountryUnicodeRangeMapper
   {
      
      private static var _instance:CountryUnicodeRangeMapper;
       
      
      public function CountryUnicodeRangeMapper()
      {
         super();
      }
      
      public static function get instance() : CountryUnicodeRangeMapper
      {
         if(!_instance)
         {
            _instance = new CountryUnicodeRangeMapper();
         }
         return _instance;
      }
      
      public function addUnicodeRanges(param1:AbstractGGSCountry) : void
      {
         var _loc2_:String = param1.ggsCountryCode;
         var _loc3_:Vector.<UnicodeRange> = param1.useUnicodeRanges;
         switch(_loc2_)
         {
            case GGSCountryCodes.JAPAN:
               _loc3_.push(UnicodeRegistry.KANA_SUPPLEMENT);
               _loc3_.push(UnicodeRegistry.KATAKANA);
               _loc3_.push(UnicodeRegistry.KATAKANA_PHONETIC_EXT);
               _loc3_.push(UnicodeRegistry.KANGXI_RADICALS);
               _loc3_.push(UnicodeRegistry.HIRAGANA);
               break;
            case GGSCountryCodes.CHINA:
               _loc3_.push(UnicodeRegistry.CJK_COMPAT);
               _loc3_.push(UnicodeRegistry.CJK_COMPAT_FORMS);
               _loc3_.push(UnicodeRegistry.CJK_COMPAT_IDEOGRAPHS);
               _loc3_.push(UnicodeRegistry.CJK_ENCLOSED_LETTERS_AND_MONTH);
               _loc3_.push(UnicodeRegistry.CJK_RADICALS_SUPPLEMENT);
               _loc3_.push(UnicodeRegistry.CJK_STROKES);
               _loc3_.push(UnicodeRegistry.CJK_SYMBOLS_AND_PUNCTUATION);
               _loc3_.push(UnicodeRegistry.CJK_UNIFIED_IDEOGRAPHS);
               _loc3_.push(UnicodeRegistry.CJK_UNIFIED_IDEOGRAPHS_EXT_A);
               _loc3_.push(UnicodeRegistry.CJK_UNIFIED_IDEOGRAPHS_EXT_B);
               _loc3_.push(UnicodeRegistry.CJK_UNIFIED_IDEOGRAPHS_EXT_C);
               _loc3_.push(UnicodeRegistry.CJK_UNIFIED_IDEOGRAPHS_EXT_D);
               break;
            case GGSCountryCodes.GREECE:
               _loc3_.push(UnicodeRegistry.COPTIC);
               _loc3_.push(UnicodeRegistry.GREEK_COPTIC);
               _loc3_.push(UnicodeRegistry.GREEK_EXTENDED);
               _loc3_.push(UnicodeRegistry.COMBINING_DIACRITICAL_MARKS);
               break;
            case GGSCountryCodes.RUSSIA:
               _loc3_.push(UnicodeRegistry.CYRILLIC_BASIC);
               _loc3_.push(UnicodeRegistry.CYRILLIC_SUPPLEMENT);
               _loc3_.push(UnicodeRegistry.CYRILLIC_EXT_A);
               _loc3_.push(UnicodeRegistry.CYRILLIC_EXT_B);
               break;
            case GGSCountryCodes.NORTH_KOREA:
            case GGSCountryCodes.SOUTH_KOREA:
               _loc3_.push(UnicodeRegistry.HANGUL_SYLLABLES);
               _loc3_.push(UnicodeRegistry.HANGUL_JAMO);
               _loc3_.push(UnicodeRegistry.HANGUL_JAMO_EXT_A);
               _loc3_.push(UnicodeRegistry.HANGUL_JAMO_EXT_B);
               _loc3_.push(UnicodeRegistry.HANGUL_COMPAT_JAMO);
         }
      }
   }
}
