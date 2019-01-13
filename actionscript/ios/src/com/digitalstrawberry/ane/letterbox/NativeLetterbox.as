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

	import flash.external.ExtensionContext;

	public class NativeLetterbox implements INativeLetterbox
	{
		private static const TAG:String = "[NativeLetterbox]";
		private static const EXTENSION_ID:String = "com.digitalstrawberry.ane.letterbox";

		private static var _context:ExtensionContext;

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

			if(!initExtensionContext())
			{
				trace(TAG, "Error creating extension context for " + EXTENSION_ID);
			}
		}


		public static function get instance():INativeLetterbox
		{
			if(_instance == null)
			{
				_canInitialize = true;
				_instance = new NativeLetterbox();
				_canInitialize = false;
			}
			return _instance;
		}


		public function setHorizontalLetterbox(size:Number, color:int, alpha:Number = 1):void
		{
			if(_context != null)
			{
				_context.call("setHorizontalLetterbox", size, color, alpha);
			}
		}


		public function setVerticalLetterbox(size:Number, color:int, alpha:Number = 1):void
		{
			if(_context != null)
			{
				_context.call("setVerticalLetterbox", size, color, alpha);
			}
		}


		public function bringToFront():void
		{
			if(_context != null)
			{
				_context.call("bringToFront");
			}
		}


		public function dispose():void
		{
			if(_context != null)
			{
				_context.dispose();
				_context = null;
				_instance = null;
			}
		}


		public function get isSupported():Boolean
		{
			return true;
		}


		public static function get VERSION():String
		{
			return NATIVE_LETTERBOX_VERSION;
		}


		/**
		 * Initializes extension context.
		 * @return <code>true</code> if initialized successfully, <code>false</code> otherwise.
		 */
		private static function initExtensionContext():Boolean
		{
			if(_context == null)
			{
				try
				{
					_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				}
				catch(e:Error)
				{
				}
			}
			return _context != null;
		}

	}
}
