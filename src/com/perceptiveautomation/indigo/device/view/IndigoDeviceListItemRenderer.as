/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/18/12
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.device.view
{
    import com.mtnlabs.graphics.MountainLabsGraphics;
    import com.perceptiveautomation.indigo.device.IIndigoDevice;
    import com.perceptiveautomation.indigo.device.IIndigoDimmerDevice;
    import com.perceptiveautomation.indigo.device.IIndigoOnOffDevice;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import spark.components.Label;
    import spark.components.NumericStepper;
    import spark.components.supportClasses.ItemRenderer;
    import spark.events.ListEvent;
    import spark.primitives.BitmapImage;

    public class IndigoDeviceListItemRenderer extends ItemRenderer
    {

        private var _indigoDevice:IIndigoDevice;

        // Child Display Objects
        private var _labelDeviceName:Label;
        private var _bitmapDeviceStatus:BitmapImage;
        private var _nsValueStepper:NumericStepper;


        public function IndigoDeviceListItemRenderer()
        {
            this.height = 28;
            this.doubleClickEnabled = true;
            this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
        }

        override public function set data(value:Object):void
        {
            if (_indigoDevice !== null)
            {
                removeDeviceListeners();
            }

            super.data = value;

            if (value is IIndigoDevice)
            {
                _indigoDevice = value as IIndigoDevice;
                updateRendererView();
                addDeviceListeners();
            }
        }

        override protected function createChildren():void
        {
            super.createChildren();

            if (!_bitmapDeviceStatus)
            {
                _bitmapDeviceStatus = new BitmapImage();
                _bitmapDeviceStatus.source = MountainLabsGraphics.iconBulletRed;
                _bitmapDeviceStatus.left = 7;
                _bitmapDeviceStatus.top = 7;
                this.addElement( _bitmapDeviceStatus );
            }

            if (!_labelDeviceName)
            {
                _labelDeviceName = new Label();
                _labelDeviceName.text = (_indigoDevice !== null) ?_indigoDevice.name : "Name Not Available";
                _labelDeviceName.left = 24;
                _labelDeviceName.top = 9;
                this.addElement( _labelDeviceName );
            }

            if (!_nsValueStepper)
            {
                _nsValueStepper = new NumericStepper();
                _nsValueStepper.minimum = 0;
                _nsValueStepper.maximum = 100;
                _nsValueStepper.width = 48;
                _nsValueStepper.height = 21;
                _nsValueStepper.top = 4;
//                this.addElement(_nsValueStepper);
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            updateRendererView();
        }

        override protected function updateDisplayList(unscaledWidth:Number,  unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (_indigoDevice is IIndigoDimmerDevice)
            {
                _nsValueStepper.includeInLayout = true;
                _nsValueStepper.visible = true;
                _nsValueStepper.left = _labelDeviceName.left + _labelDeviceName.width + 7;
            }
            else
            {
                _nsValueStepper.includeInLayout = false;
                _nsValueStepper.visible = false;
            }
        }

        protected function addDeviceListeners():void
        {
            _indigoDevice.addEventListener("isOnChanged", handleDevicePropertyChangeEvent);
        }

        protected function removeDeviceListeners():void
        {
            _indigoDevice.removeEventListener("isOnChanged", handleDevicePropertyChangeEvent);
        }

        protected function handleDevicePropertyChangeEvent(event:Event):void
        {
            updateRendererView();
        }

        protected function handleMouseDoubleClick(event:MouseEvent):void
        {
            var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
            this.owner.dispatchEvent(listEvent);
        }

        protected function updateRendererView():void
        {
            if (_indigoDevice !== null)
            {
                _labelDeviceName.text = (_indigoDevice.name == "") ? "Name Not Available" : _indigoDevice.name;

                if (_indigoDevice is IIndigoOnOffDevice)
                {
                    _bitmapDeviceStatus.source = (IIndigoOnOffDevice(_indigoDevice).isOn) ? MountainLabsGraphics.iconBulletGreen : MountainLabsGraphics.iconBulletRed;
                }

                if (_indigoDevice is IIndigoDimmerDevice)
                {
                    _nsValueStepper.value = IIndigoDimmerDevice(_indigoDevice).brightness;
                }
            }
        }
    }
}
