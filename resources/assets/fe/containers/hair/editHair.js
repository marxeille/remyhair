import { connect } from "react-redux"
import EditHair from "../../components/hair/editHair";

function mapStateToProps(state) {
    return {
        jwt: state.default.env.jwt,
        hair: state.default.hair.hair,
        filters: state.default.hair.filters ? state.default.hair.filters : {},
        page_number: state.default.hair.currentPage ? state.default.hair.currentPage : 1,
        hairs: state.default.hair.hairs,
        hairColors: state.default.env.hair_colors,
        hairStyles: state.default.env.hair_styles
    }
}

export default connect(mapStateToProps)(EditHair);
