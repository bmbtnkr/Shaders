/***********************************************/
/********** User Tweakables ********************/
/***********************************************/
float3 diffuseColor
<
    string UIName = "Diffuse Color";
    string Type = "Color";
> = {0.5, 0.5, 0.5};

float4 light1Dir : DIRECTION
<
    string UIName = "Light 1 - Directional Light";
    string Space = "World";
> = {0.0, -1.0, -1.0, 0.0};

/***********************************************/
/********** Auto Tracked Tweakables ************/
/***********************************************/
float4x4 WorldViewProjection     : WorldViewProjection   < string UIWidget = "None"; >;
float4x4 WorldInverseTranspose   : WorldInverseTranspose < string UIWidget = "None"; >;
float4x4 ViewInverse             : ViewInverse           < string UIWidget = "None"; >;
float4x4 World                   : World                 < string UIWidget = "None"; >;

/****************************************************/
/********** CG SHADER FUNCTIONS *********************/
/****************************************************/
// input from application
struct app2vert {
    float4 position : POSITION;
    float4 normal   : NORMAL;
};


// output to fragment program
struct vert2fragment {
        float4 position    : POSITION;
        float3 worldNormal : TEXCOORD0;
};

/**************************************/
/***** VERTEX SHADER ******************/
/**************************************/

vert2fragment VS(app2vert IN)
{
    vert2fragment OUT;
    OUT.position = mul(IN.position, WorldViewProjection);
    OUT.worldNormal = mul(IN.normal, WorldInverseTranspose).xyz;
    return OUT;
}

/**************************************/
/***** FRAGMENT SHADER ****************/
/**************************************/
float4 PSBasic (vert2fragment IN) : COLOR
{

    float3 shading = saturate(dot(normalize(IN.worldNormal), normalize(-light1Dir.xyz))) * diffuseColor;

    return float4(shading, 1.0);
}

/****************************************************/
/********** TECHNIQUES ******************************/
/****************************************************/
technique Basic
{
    pass P0
    {
        ZEnable = true;
        ZWriteEnable = true;
        ZFunc = LessEqual;
        CullMode = none;
        AlphaBlendEnable = true;
        VertexShader = compile vs_2_0 VS();
        PixelShader = compile ps_2_0 PSBasic();
    }
}
