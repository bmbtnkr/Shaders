/***********************************************/
/*** automatically-tracked "tweakables" ********/
/***********************************************/

half4x4 WorldViewProjection     : WorldViewProjection   < string UIWidget = "None"; >;
half4x4 WorldInverseTranspose   : WorldInverseTranspose < string UIWidget = "None"; >;
half4x4 ViewInverse             : ViewInverse           < string UIWidget = "None"; >;
half4x4 World                   : World                 < string UIWidget = "None"; >;

/****************************************************/
/********** CG SHADER FUNCTIONS *********************/
/****************************************************/
// input from application
struct app2vert {
    float4 position : POSITION;
};


// output to fragment program
struct vert2fragment {
        float4 position : POSITION;
};

/**************************************/
/***** VERTEX SHADER ******************/
/**************************************/

vert2fragment VS(app2vert IN)
{
    vert2fragment OUT;
    OUT.position = mul(IN.position, WorldViewProjection);
    return OUT;
}

//////////////////////
// Shader Body
//////////////////////

float4 PSBasic (vert2fragment IN) : COLOR
{

    float4 Color = float4(1.0, 0.0, 1.0, 1.0);
    return Color;
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
