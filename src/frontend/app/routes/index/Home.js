import React, {Component, PropTypes} from 'react';
import Style from '../../../assets/style/home.scss';

const Home = ({children}) => {
	return (
		<div className="home-content" id="home">
			<nav className="navbar navbar-default">
				<div className="container-fluid">
					<div className="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
					    </button>
						<a href="/#home" className="navbar-brand">{window.blade.data.me.name || data.me.name} {window.blade.data.me.surname || data.me.surname}</a>
					</div>
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<ul className="nav navbar-nav navbar-right">
							<li><a href="#skills">Skills</a></li>
							<li><a href="#experiences">Experiences</a></li>
							<li><a href="#works">Works</a></li>
							<li><a href="#contacts">Contacts</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<div className="centered-content">
				
				<div className="centered-container">
					<div className="darker-content">
						<div className="centered-title">
							{window.blade.data.me.name} {window.blade.data.me.surname}
						</div>
						<div className="centered-subtitle">
							{window.blade.data.quote}
						</div>
					</div>
					<div className="centered-info">Site under construction</div>
				</div>
				
				
				
			</div>
		</div>
	);
};

Home.propTypes = {
	children: PropTypes.any
};

export default Home;