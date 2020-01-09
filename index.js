import PropTypes from 'prop-types';
import React from 'react';
import {requireNativeComponent, AppRegistry } from 'react-native';
import { numericLiteral } from '@babel/types';

function NativoAdComponent(props) {
    //console.log("Props "+JSON.stringify(props));
    const [sectionUrl, setSectionUrl] = React.useState();
    const [locationId, setLocationId] = React.useState("0");
    const [onNativeAdClick, setOnNativeAdClick] = React.useState();
    const [onDisplayAdClick, setOnDisplayAdClick] = React.useState();
    const { nativeAdTemplate, videoAdTemplate, standardDisplayAdTemplate, ...other } = props;

    _onNativeAdClick = (event) => {
        if (!props.onNativeAdClick) {
          return;
        }
        props.onNativeAdClick(event.nativeEvent);
    }
    _onDisplayAdClick = (event) => {
        if (!props.onDisplayAdClick) {
          return;
        }
        props.onDisplayAdClick(event.nativeEvent);
    }
    
    const allTemplates = {...nativeAdTemplate, ...videoAdTemplate, ...standardDisplayAdTemplate};
    for (const templateName in allTemplates) {
        AppRegistry.registerComponent(templateName, () => allTemplates[templateName]);
    }
    const nativeTemplateName = getFirstKey(nativeAdTemplate);
    const videoTemplateName = getFirstKey(videoAdTemplate);
    const stdDisplayTemplateName = getFirstKey(standardDisplayAdTemplate);

    return (
        <NativoAd {...other} 
            onNativeAdClick={_onNativeAdClick} 
            onDisplayAdClick={_onDisplayAdClick} 
            nativeAdTemplate={nativeTemplateName} 
            videoAdTemplate={videoTemplateName} 
            stdDisplayAdTemplate={stdDisplayTemplateName} />
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


function NativoWebComponent(props) {
    const [sectionUrl, setSectionUrl] = React.useState();
    const [locationId, setLocationId] = React.useState("0");
    const [shouldScroll, setShouldScroll] = React.useState(false);

    _onClickExternalLink = (event) => {
        if (!props.onClickExternalLink) {
          return;
        }
        props.onClickExternalLink(event.nativeEvent);
    }
    _onFinishLoading = (event) => {
        if (!props.onFinishLoading) {
          return;
        }
        props.onFinishLoading(event.nativeEvent);
    }
    return (<NativoWebContent {...props} onClickExternalLink={this._onClickExternalLink} onFinishLoading={this._onFinishLoading} />);
}

NativoWebComponent.propTypes = {
    sectionUrl: PropTypes.string,
    locationId: PropTypes.number,
    shouldScroll: PropTypes.bool,
    onFinishLoading: PropTypes.func,
    onClickExternalLink: PropTypes.func
};
const NativoWebContent = requireNativeComponent('NativoWebContent', NativoWebComponent);

export { NativoAdComponent as NativoAd, NativoWebComponent as NativoWebContent };
