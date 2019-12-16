import PropTypes from 'prop-types';
import React from 'react';
import {requireNativeComponent, AppRegistry } from 'react-native';
import { numericLiteral } from '@babel/types';

function NativoAdComponent(props) {
    console.log("Props "+JSON.stringify(props));
    const [sectionUrl, setSectionUrl] = React.useState();
    const [locationId, setLocationId] = React.useState("0");
    const [onNativeAdClick, setOnNativeAdClick] = React.useState();
    const [onDisplayAdClick, setOnDisplayAdClick] = React.useState();
    const { nativeAdTemplate, videoAdTemplate, standardDisplayAdTemplate, ...other } = props;
    
    const allTemplates = {...nativeAdTemplate, ...videoAdTemplate, ...standardDisplayAdTemplate};
    for (const templateName in allTemplates) {
        AppRegistry.registerComponent(templateName, () => allTemplates[templateName]);
    }
    const nativeTemplateName = getFirstKey(nativeAdTemplate);
    const videoTemplateName = getFirstKey(videoAdTemplate);
    const stdDisplayTemplateName = getFirstKey(standardDisplayAdTemplate);

    return (
        <NativoAd {...other} 
            nativeAdTemplate={nativeTemplateName} 
            videoAdTemplate={videoTemplateName} 
            stdDisplayTemplate={stdDisplayTemplateName} />
    );
}

function getFirstKey(obj) {
    const keys = Object.keys(obj);
    if (keys && keys.length > 0) {
        return keys[0];
    }
    return null;
}

NativoAdComponent.propTypes = {
    sectionUrl: PropTypes.string,
    locationId: PropTypes.number,
    nativeAdTemplate: PropTypes.object,
    videoAdTemplate: PropTypes.object,
    standardDisplayAdTemplate: PropTypes.object,
    onNativeAdClick: PropTypes.func,
    onDisplayAdClick: PropTypes.func
};

const NativoAd = requireNativeComponent('NativoAd', NativoAdComponent);


export default NativoAdComponent;
