/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2019 Digital Strawberry LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.digitalstrawberry.ane.letterbox
{

	public class NativeLetterbox implements INativeLetterbox
	{

		// Singleton stuff
		private static var _canInitialize:Boolean;
		private static var _instance:INativeLetterbox;


		/**
		 * @private
		 */
		public function NativeLetterbox()
		{
			if(!_canInitialize)
			{
				throw new Error("NativeLetterbox is a singleton, use instance getter.");
			}
		}


		public static function get instance():INativeLetterbox
		{
			if(!_instance)
			{
				_canInitialize = true;
				_instance = new NativeLetterbox();
				_canInitialize = false;
			}
			return _instance;
		}


		public static function get VERSION():String
		{
			return NATIVE_LETTERBOX_VERSION;
		}


		public function dispose():void
		{
		}


		public function get isSupported():Boolean
		{
			return false;
		}


		public function setHorizontalLetterbox(size:Number, color:int, alpha:Number = 1):void
		{
		}


		public function setVerticalLetterbox(size:Number, color:int, alpha:Number = 1):void
		{
		}


		public function bringToFront():void
		{
		}
	}
}
