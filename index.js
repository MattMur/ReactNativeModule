import PropTypes from 'prop-types';
import React from 'react';
import {requireNativeComponent, NativeModules, AppRegistry } from 'react-native';

function NativoAdComponent(props) {
    const [sectionUrl, setSectionUrl] = React.useState("");
    const [locationId, setLocationId] = React.useState("0");
    const [nativeAdTemplate, setNativeAdTemplate] = React.useState("");
    const [videoAdTemplate, setVideoAdTemplate] = React.useState("");
    console.log("Props "+JSON.stringify(props));

    return (
        <NativoAd {...props} />
    );
}

NativoAdComponent.propTypes = {
    sectionUrl: PropTypes.string,
    locationId: PropTypes.string,
    nativeAdTemplate: PropTypes.string,
    videoAdTemplate: PropTypes.string
};

const NativoAd = requireNativeComponent('NativoAd', NativoAdComponent);

// NativoSDK JS Methods
const NativoSDK = NativeModules.NativoSDK;
NativoSDK.registerTemplateComponent = (templateName, component) => {
    AppRegistry.registerComponent(templateName, () => component);
}

export default NativoAdComponent;
