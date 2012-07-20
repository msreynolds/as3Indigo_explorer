/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/18/12
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.view.components {
import com.perceptiveautomation.indigo.device.IIndigoDevice;
import com.perceptiveautomation.indigo.variable.IIndigoVariable;

import spark.components.Label;

import spark.components.supportClasses.ItemRenderer;

public class IndigoVariableListItemRenderer extends ItemRenderer {

    // Child Display Objects
    private var _labelVariableName:Label;
    private var _labelVariableValue:Label;

    private var _indigoVariable:IIndigoVariable;

    public function IndigoVariableListItemRenderer() {
        this.height = 28;
    }

    override public function set data(value:Object):void {

        if (value is IIndigoVariable) {
            _indigoVariable = value as IIndigoVariable;
        }
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_labelVariableName) {
            _labelVariableName = new Label();
            _labelVariableName.text = (_indigoVariable !== null) ? _indigoVariable.name : "Name Not Available";
            _labelVariableName.left = 7;
            _labelVariableName.top = 9;
            this.addElement( _labelVariableName );
        }

        if (!_labelVariableValue) {
            _labelVariableValue = new Label();
            _labelVariableValue.text = (_indigoVariable !== null) ? _indigoVariable.value.toString() : "-";
            _labelVariableValue.right = 7;
            _labelVariableValue.top = 9;
            this.addElement( _labelVariableValue );
        }
    }

    override protected function commitProperties():void {
        super.commitProperties();
        _labelVariableName.text = (_indigoVariable !== null) ?_indigoVariable.name : "Name Not Available";
        _labelVariableValue.text = (_indigoVariable !== null) ?_indigoVariable.value.toString() : "-";

    }

}

}
