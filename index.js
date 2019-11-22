import PropTypes from 'prop-types';
import React from 'react';
import {requireNativeComponent, AppRegistry } from 'react-native';

function NativoAdComponent(props) {
    console.log("Props "+JSON.stringify(props));
    const [sectionUrl, setSectionUrl] = React.useState();
    const [locationId, setLocationId] = React.useState("0");
    const [onNativeAdClick, setOnNativeAdClick] = React.useState();
    const [onDisplayAdClick, setOnDisplayAdClick] = React.useState();
    const { nativeAdTemplate, videoAdTemplate, ...other } = props;
    let nativeTemplateName;
    let videoTemplateName;

    const nativeKeys = Object.keys(nativeAdTemplate);
    if (nativeKeys && nativeKeys.length > 0) {
        nativeTemplateName = nativeKeys[0];
        AppRegistry.registerComponent(nativeTemplateName, () => nativeAdTemplate[nativeTemplateName]);
    }
    const videoKeys = Object.keys(videoAdTemplate);
    if (videoKeys && videoKeys.length > 0) {
        videoTemplateName = videoKeys[0];
        AppRegistry.registerComponent(videoTemplateName, () => videoAdTemplate[videoTemplateName]);
    }

    return (
        <NativoAd {...other} nativeAdTemplate={nativeTemplateName} videoAdTemplate={videoTemplateName} />
    );
}

NativoAdComponent.propTypes = {
    sectionUrl: PropTypes.string,
    locationId: PropTypes.number,
    nativeAdTemplate: PropTypes.object,
    videoAdTemplate: PropTypes.object,
    onNativeAdClick: PropTypes.func,
    onDisplayAdClick: PropTypes.func
};

const NativoAd = requireNativeComponent('NativoAd', NativoAdComponent);


export default NativoAdComponent;
